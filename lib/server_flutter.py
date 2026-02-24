import cv2
import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS
from ultralytics import YOLO
from data_label_aksara import CLASS_NAMES
import os
import re
import os

# Initialize Flask app
app = Flask(__name__)
# Enable CORS to allow requests from your Flutter web app
CORS(app)
model = YOLO("best.pt")

# Create an 'uploads' directory if it doesn't exist
if not os.path.exists('uploads'):
    os.makedirs('uploads')

def normalize_image_size(img, max_side=1280):
    """Resize down (keep aspect ratio) so variasi resolusi HP tidak mengubah skala deteksi."""
    h, w = img.shape[:2]
    scale = min(1.0, float(max_side) / max(h, w))
    if scale < 1.0:
        new_w, new_h = int(w * scale), int(h * scale)
        img = cv2.resize(img, (new_w, new_h), interpolation=cv2.INTER_AREA)
    return img

def process_image(img):
    """Return List[List[{'aksara': str, 'letak': 'atas'|'tengah'|'bawah'}]] sesuai kebutuhan user.

    Perbaikan utama:
    - Kelompok baris hanya memakai aksara tubuh (tinggi terbesar) agar sandhangan
      atas/bawah tidak dianggap baris baru.
    - Ambang baris dihitung dari persentil tinggi, bukan rata-rata yang bias.
    - Sandhangan dilekatkan ke aksara tubuh terdekat via overlap horizontal dan
      posisi vertikal relatif.
    """
    img_height = img.shape[0]
    result = model.predict(img)[0]

    # 1. Kumpulkan deteksi + fitur dasar
    detections = []
    for idx, box in enumerate(result.boxes):
        x1, y1, x2, y2 = [int(c) for c in box.xyxy[0].tolist()]
        class_id = int(box.cls[0])
        class_name = result.names[class_id]
        h = y2 - y1
        w = x2 - x1
        detections.append({
            'id': idx,
            'class_name': class_name,
            'bbox': [x1, y1, x2, y2],
            'h': h,
            'w': w,
            'cx': (x1 + x2) / 2.0,
            'cy': (y1 + y2) / 2.0,
        })

    if not detections:
        return []

    # 2. Tentukan aksara tubuh (basis) via persentil tinggi
    heights = [d['h'] for d in detections]
    height_threshold = float(np.percentile(heights, 65))
    for d in detections:
        d['is_base'] = d['h'] >= height_threshold
    base_dets = [d for d in detections if d['is_base']]
    if not base_dets:  # fallback jika semua kecil
        base_dets = detections[:]
        for d in base_dets:
            d['is_base'] = True

    # 3. Kelompokkan baris memakai aksara tubuh saja
    line_gap = max(np.median([d['h'] for d in base_dets]) * 0.6, img_height * 0.03)
    base_sorted = sorted(base_dets, key=lambda d: d['cy'])
    lines = []  # tiap elemen: {'center': float, 'members': [id, ...]}
    for det in base_sorted:
        if not lines:
            lines.append({'center': det['cy'], 'members': [det['id']]})
            continue
        current_center = lines[-1]['center']
        if abs(det['cy'] - current_center) <= line_gap:
            lines[-1]['members'].append(det['id'])
            base_members = [d for d in base_dets if d['id'] in lines[-1]['members']]
            lines[-1]['center'] = float(np.mean([m['cy'] for m in base_members]))
        else:
            lines.append({'center': det['cy'], 'members': [det['id']]})

    # 4. Tambah deteksi lain ke baris terdekat (berdasar center Y)
    already_used = {mid for ln in lines for mid in ln['members']}
    for det in detections:
        if det['id'] in already_used:
            continue
        nearest = min(lines, key=lambda ln: abs(det['cy'] - ln['center']))
        nearest['members'].append(det['id'])

    # 5. Strukturkan per baris jadi urutan aksara + sandhangan
    id_map = {d['id']: d for d in detections}
    final_output = []
    for ln in lines:
        members = [id_map[i] for i in ln['members']]
        bases = [m for m in members if m['is_base']]
        if not bases:
            bases = members[:]
        bases.sort(key=lambda d: d['cx'])

        used = set()
        tokens = []
        for base in bases:
            used.add(base['id'])
            base_bbox = base['bbox']
            mid_y = (base_bbox[1] + base_bbox[3]) / 2.0
            above, below = [], []
            for other in members:
                if other['id'] in used:
                    continue
                obox = other['bbox']
                overlap_x = min(base_bbox[2], obox[2]) - max(base_bbox[0], obox[0])
                if overlap_x <= 0 or overlap_x < 0.2 * min(base_bbox[2] - base_bbox[0], obox[2] - obox[0]):
                    continue
                if other['cy'] < mid_y - base['h'] * 0.1:
                    above.append(other)
                    used.add(other['id'])
                elif other['cy'] > mid_y + base['h'] * 0.1:
                    below.append(other)
                    used.add(other['id'])
            above.sort(key=lambda d: d['cx'])
            below.sort(key=lambda d: d['cx'])

            tokens.append({'aksara': base['class_name'], 'letak': 'tengah'})
            for b in below:
                tokens.append({'aksara': b['class_name'], 'letak': 'bawah'})
            for a in above:
                tokens.append({'aksara': a['class_name'], 'letak': 'atas'})

        # deteksi tersisa diasumsikan aksara tubuh mandiri
        for other in members:
            if other['id'] in used:
                continue
            tokens.append({'aksara': other['class_name'], 'letak': 'tengah'})
            used.add(other['id'])

        final_output.append(tokens)

    return final_output

def cari_index_class_code(class_code):
    for index, item in enumerate(CLASS_NAMES):
        if item['class_code'] == class_code:
            return index
    return 'not found'

def normalize_scan_translation(text):
    """Normalize common OCR/transliteration artifacts."""
    normalized = text

    # Fix duplicated syllable after pepet that can appear as "Ke`ka" instead of "ke`".
    normalized = re.sub(
        r'([BCDFGHJKLMNPQRSTVWXYZ])e`([bcdfghjklmnpqrstvwxyz])a',
        lambda m: f"{m.group(1).lower()}e`" if m.group(1).lower() == m.group(2) else m.group(0),
        normalized,
    )

    return normalized

def translate_hasil_scan(hasil_scan):
    translate = ''
    extra_activation = False
    aksara_list = []
    for aksara_garis in hasil_scan:
        aksara_translate = []
        for aksara in aksara_garis:
            idx = cari_index_class_code(aksara['aksara'])
            if idx == 'not found':
                print('ERROR: class_code not found')
                break
            elif aksara['letak'] == 'tengah':
                aksara_list.append(CLASS_NAMES[idx])
                if CLASS_NAMES[idx]['class_code'] == 'adeg2':
                    aksara_translate.append('||')
                elif CLASS_NAMES[idx]['class_code'] == 'kom':
                    if aksara_translate[-1] == ',':
                        aksara_translate[-1] = '.'
                    else:
                        aksara_translate.append(',')
                elif CLASS_NAMES[idx]['class_code'] == 'e1':
                    extra_activation = True
                    continue
                elif CLASS_NAMES[idx]['class_code'] == 'o' and aksara_translate[-1].endswith('e`'):
                    aksara_translate[-1] = aksara_translate[-1][:-2] + 'o'
                elif CLASS_NAMES[idx]['class_code'] == '_h1':
                    aksara_translate[-1] = aksara_translate[-1] + 'h'
                elif CLASS_NAMES[idx]['class_code'].startswith('-'):
                    aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                elif CLASS_NAMES[idx]['class_code'] in ['_h', '_hr', '_hre', '_hru', '_hu', '_hy', '_hyu', '_s', '_sr', '_sre', '_sru', '_su', '_syu', '_p', '_pr', '_pre', '_pru', '_pu', '_py', '_pyu', '_P', '_Pr', '_Pre', '_Pru', '_Pu', '_Py', '_Pyu']:
                    if aksara_translate[-1].endswith('e`'):
                        aksara_translate[-1] = aksara_translate[-1][:-2] + CLASS_NAMES[idx]['terjemahan'] + 'e`'
                    elif aksara_translate[-1].endswith('a'):
                        if CLASS_NAMES[idx]['class_code'] in ['_h', '_hr', '_hy', '_s', '_sr', '_p', '_pr', '_py', '_P', '_Pr', '_Py']:
                            aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan'] + 'a'
                        else:
                            aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
                    else:
                        aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                elif not CLASS_NAMES[idx]['terjemahan'].endswith(('u', 'A', 'I', 'E', 'U', 'O')):
                    if len(aksara_list) >= 2:
                        if extra_activation == True:
                            aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'e`')
                            extra_activation = False
                        else:
                            aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'a')
                    else:
                        aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'a')
                else:
                    aksara_translate.append(CLASS_NAMES[idx]['terjemahan'])
            elif aksara['letak'] == 'atas':
                if CLASS_NAMES[idx]['class_code'] == '_r1':
                    aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                elif CLASS_NAMES[idx]['class_code'] == 'alt':
                    if aksara_list[-1]['class_code'] == 'k':
                        aksara_translate[-1] = 'kha'
                    elif aksara_list[-1]['class_code'] == 'p':
                        aksara_translate[-1] = 'fa'
                    elif aksara_list[-1]['class_code'] == 'd':
                        aksara_translate[-1] = 'dza'
                    elif aksara_list[-1]['class_code'] == 'g':
                        aksara_translate[-1] = 'gha'
                    elif aksara_list[-1]['class_code'] == 'j':
                        aksara_translate[-1] = 'za'
                    else:
                        continue
                elif CLASS_NAMES[idx]['class_code'] == 'ealt':
                    if aksara_list[-1]['class_code'] == 'k':
                        aksara_translate[-1] = 'khe'
                    elif aksara_list[-1]['class_code'] == 'p':
                        aksara_translate[-1] = 'fe'
                    elif aksara_list[-1]['class_code'] == 'd':
                        aksara_translate[-1] = 'dze'
                    elif aksara_list[-1]['class_code'] == 'g':
                        aksara_translate[-1] = 'ghe'
                    elif aksara_list[-1]['class_code'] == 'j':
                        aksara_translate[-1] = 'ze'
                    else:
                        continue
                elif CLASS_NAMES[idx]['class_code'] == 'e':
                    if aksara_translate[-1].endswith(('a', 'i', 'u', 'e', 'o')):
                        aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
                    else:
                        aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                elif CLASS_NAMES[idx]['class_code'] == 'eng':
                    if aksara_translate[-1].endswith(('a', 'i', 'u', 'e', 'o')):
                        aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
                    else:
                        aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                elif CLASS_NAMES[idx]['class_code'] == 'i':
                    if aksara_translate[-1].endswith(('a', 'i', 'u', 'e', 'o')):
                        aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
                    else:
                        aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                elif CLASS_NAMES[idx]['class_code'] == 'ng':
                    aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
                else:
                    continue
            elif aksara['letak'] == 'bawah':
                if 'bawah' in CLASS_NAMES[idx]['letak']:
                    aksara_list.append(CLASS_NAMES[idx])
                    if aksara_translate[-1].endswith('e`'):
                        aksara_translate[-1] = aksara_translate[-1][:-2]
                        aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'e`')
                    else:
                        aksara_translate[-1] = aksara_translate[-1][:-1]
                        if not CLASS_NAMES[idx]['terjemahan'].endswith(('a', 'i', 'u', 'e', 'o')):
                            aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'a')
                        else:
                            aksara_translate.append(CLASS_NAMES[idx]['terjemahan'])
                else:
                    continue
        for aksara in aksara_translate:
            translate = translate + aksara
        translate = translate + '\n'
    return normalize_scan_translation(translate)

@app.route('/translate', methods=['POST'])
def translate_image():
    # Check if an image file is in the request
    if 'image' not in request.files:
        return jsonify({'error': 'No image file provided'}), 400

    file = request.files['image']

    # Check if the file is empty
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    if file:
        filestr = file.read()
        npimg = np.frombuffer(filestr, np.uint8)
        img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
        img = normalize_image_size(img)  # normalisasi resolusi agar ambang berbasis persentase konsisten

        processed_data = process_image(img)
        translate_result = translate_hasil_scan(processed_data)

        # translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

        # Return the result as JSON
        return jsonify({'translation': translate_result})

    return jsonify({'error': 'An unknown error occurred'}), 500

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True, threaded=True)
