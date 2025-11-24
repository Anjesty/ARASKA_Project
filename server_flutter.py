import cv2
import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS
from ultralytics import YOLO
from data_label_aksara import CLASS_NAMES
import os

# Initialize Flask app
app = Flask(__name__)
# Enable CORS to allow requests from your Flutter web app
CORS(app)
model = YOLO("best.pt")

# Create an 'uploads' directory if it doesn't exist                                                                            
if not os.path.exists('uploads'):
    os.makedirs('uploads')

def process_image(img):
    """Return List[List[{'aksara': str, 'letak': 'atas'|'tengah'|'bawah'}]] sesuai kebutuhan user.

    Tahap:
    1. Deteksi semua bbox + kelas.
    2. Kelompokkan ke baris berdasar Y-center dengan toleransi.
    3. Untuk tiap baris, tentukan kelompok (base + aksara di atas/bawah) dengan overlap horizontal.
    4. Susun urutan: (semua atas kiri→kanan), base, (semua bawah kiri→kanan) per cluster.
    5. Gabung seluruh cluster menghasilkan satu list baris.
    """
    resized = cv2.resize(img, (1200, 1200))
    img_height = resized.shape[0]
    results = model.predict(img, imgsz=1200)
    result = results[0]

    # 1. Kumpulkan deteksi
    detections = []
    for box in result.boxes:
        x1, y1, x2, y2 = [int(c) for c in box.xyxy[0].tolist()]
        class_id = int(box.cls[0])
        class_name = result.names[class_id]
        detections.append({'class_name': class_name, 'bbox': [x1, y1, x2, y2]})

    if not detections:
        return []

    # 2. Kelompokkan jadi baris
    detections.sort(key=lambda d: d['bbox'][1])
    lines = []
    current = [detections[0]]
    for det in detections[1:]:
        avg_center_y = sum((d['bbox'][1] + d['bbox'][3]) / 2 for d in current) / len(current)
        det_center_y = (det['bbox'][1] + det['bbox'][3]) / 2
        avg_h = sum(d['bbox'][3] - d['bbox'][1] for d in current) / len(current)
        tolerance = max(avg_h * 0.5, img_height * 0.1)
        if abs(det_center_y - avg_center_y) < tolerance:
            current.append(det)
        else:
            lines.append(current)
            current = [det]
    lines.append(current)

    # 3. Strukturkan per baris
    final_output = []
    for line in lines:
        line.sort(key=lambda d: d['bbox'][0])  # kiri->kanan
        used = set()
        tokens = []
        for i, base in enumerate(line):
            if i in used:
                continue
            base_bbox = base['bbox']
            used.add(i)
            mid_y = base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2
            above = []
            below = []
            for j, other in enumerate(line):
                if j in used:
                    continue
                obox = other['bbox']
                overlap_x = base_bbox[0] < obox[2] and base_bbox[2] > obox[0]
                if not overlap_x:
                    continue
                if obox[3] < mid_y:  # di atas
                    above.append(other)
                    used.add(j)
                elif obox[1] > mid_y:  # di bawah
                    below.append(other)
                    used.add(j)
            # sort horizontal
            above.sort(key=lambda d: d['bbox'][0])
            below.sort(key=lambda d: d['bbox'][0])
            # tambah ke tokens
            tokens.append({'aksara': base['class_name'], 'letak': 'tengah'})
            for b in below:
                tokens.append({'aksara': b['class_name'], 'letak': 'bawah'})
            for a in above:
                tokens.append({'aksara': a['class_name'], 'letak': 'atas'})
        final_output.append(tokens)

    return final_output

def cari_index_class_code(class_code):
    for index, item in enumerate(CLASS_NAMES):
        if item['class_code'] == class_code:
            return index
    return 'not found'

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
                        aksara_transate[-1] = 'gha'
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
                        aksara_transate[-1] = 'ghe'
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
    return translate

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

        processed_data = process_image(img)
        translate_result = translate_hasil_scan(processed_data)
        
        # translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

        # Return the result as JSON
        return jsonify({'translation': translate_result})

    return jsonify({'error': 'An unknown error occurred'}), 500

if __name__ == '__main__':
    # Run the app on localhost, port 5000
    app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)









# import cv2
# import numpy as np
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# from ultralytics import YOLO
# from data_label_aksara import CLASS_NAMES
# import os

# # Initialize Flask app
# app = Flask(__name__)
# # Enable CORS to allow requests from your Flutter web app
# CORS(app)
# model = YOLO("best.pt")

# # Create an 'uploads' directory if it doesn't exist                                                                            
# if not os.path.exists('uploads'):
#     os.makedirs('uploads')

# def process_image(img):
#     """Return List[List[{'aksara': str, 'letak': 'atas'|'tengah'|'bawah'}]] sesuai kebutuhan user.

#     Tahap:
#     1. Deteksi semua bbox + kelas.
#     2. Kelompokkan ke baris berdasar Y-center dengan toleransi.
#     3. Untuk tiap baris, tentukan kelompok (base + aksara di atas/bawah) dengan overlap horizontal.
#     4. Susun urutan: (semua atas kiri→kanan), base, (semua bawah kiri→kanan) per cluster.
#     5. Gabung seluruh cluster menghasilkan satu list baris.
#     """
#     img_height = img.shape[0]
#     results = model.predict(img)
#     result = results[0]

#     # 1. Kumpulkan deteksi
#     detections = []
#     for box in result.boxes:
#         x1, y1, x2, y2 = [int(c) for c in box.xyxy[0].tolist()]
#         class_id = int(box.cls[0])
#         class_name = result.names[class_id]
#         detections.append({'class_name': class_name, 'bbox': [x1, y1, x2, y2]})

#     if not detections:
#         return []

#     # 2. Kelompokkan jadi baris
#     detections.sort(key=lambda d: d['bbox'][1])
#     lines = []
#     current = [detections[0]]
#     for det in detections[1:]:
#         avg_center_y = sum((d['bbox'][1] + d['bbox'][3]) / 2 for d in current) / len(current)
#         det_center_y = (det['bbox'][1] + det['bbox'][3]) / 2
#         avg_h = sum(d['bbox'][3] - d['bbox'][1] for d in current) / len(current)
#         tolerance = max(avg_h * 0.5, img_height * 0.2)
#         if abs(det_center_y - avg_center_y) < tolerance:
#             current.append(det)
#         else:
#             lines.append(current)
#             current = [det]
#     lines.append(current)

#     # 3. Strukturkan per baris
#     final_output = []
#     for line in lines:
#         line.sort(key=lambda d: d['bbox'][0])  # kiri->kanan
#         used = set()
#         tokens = []
#         for i, base in enumerate(line):
#             if i in used:
#                 continue
#             base_bbox = base['bbox']
#             used.add(i)
#             mid_y = base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2
#             above = []
#             below = []
#             for j, other in enumerate(line):
#                 if j in used:
#                     continue
#                 obox = other['bbox']
#                 overlap_x = base_bbox[0] < obox[2] and base_bbox[2] > obox[0]
#                 if not overlap_x:
#                     continue
#                 if obox[3] < mid_y:  # di atas
#                     above.append(other)
#                     used.add(j)
#                 elif obox[1] > mid_y:  # di bawah
#                     below.append(other)
#                     used.add(j)
#             # sort horizontal
#             above.sort(key=lambda d: d['bbox'][0])
#             below.sort(key=lambda d: d['bbox'][0])
#             # tambah ke tokens
#             tokens.append({'aksara': base['class_name'], 'letak': 'tengah'})
#             for b in below:
#                 tokens.append({'aksara': b['class_name'], 'letak': 'bawah'})
#             for a in above:
#                 tokens.append({'aksara': a['class_name'], 'letak': 'atas'})
#         final_output.append(tokens)

#     return final_output

# def cari_index_class_code(class_code):
#     for index, item in enumerate(CLASS_NAMES):
#         if item['class_code'] == class_code:
#             return index
#     return 'not found'

# def translate_hasil_scan(hasil_scan):
#     translate = ''
#     extra_activation = False
#     aksara_list = []
#     for aksara_garis in hasil_scan:
#         aksara_translate = []
#         for aksara in aksara_garis:
#             idx = cari_index_class_code(aksara['aksara'])
#             if idx == 'not found':
#                 print('ERROR: class_code not found')
#                 break
#             elif aksara['letak'] == 'tengah':
#                 aksara_list.append(CLASS_NAMES[idx])
#                 if CLASS_NAMES[idx]['class_code'] == 'adeg2':
#                     aksara_translate.append('||')
#                 elif CLASS_NAMES[idx]['class_code'] == 'kom':
#                     if aksara_translate[-1] == ',':
#                         aksara_translate[-1] = '.'
#                     else:
#                         aksara_translate.append(',')
#                 elif CLASS_NAMES[idx]['class_code'] == 'e1':
#                     extra_activation = True
#                     continue
#                 elif CLASS_NAMES[idx]['class_code'] == 'o' and aksara_translate[-1].endswith('e`'):
#                     aksara_translate[-1] = aksara_translate[-1][:-2] + 'o'
#                 elif CLASS_NAMES[idx]['class_code'] == '_h1':
#                     aksara_translate[-1] = aksara_translate[-1] + 'h'
#                 elif CLASS_NAMES[idx]['class_code'].startswith('-'):
#                     aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 elif CLASS_NAMES[idx]['class_code'] in ['_h', '_hr', '_hre', '_hru', '_hu', '_hy', '_hyu', '_s', '_sr', '_sre', '_sru', '_su', '_syu', '_p', '_pr', '_pre', '_pru', '_pu', '_py', '_pyu', '_P', '_Pr', '_Pre', '_Pru', '_Pu', '_Py', '_Pyu']:
#                     if aksara_translate[-1].endswith('e`'):
#                         aksara_translate[-1] = aksara_translate[-1][:-2] + CLASS_NAMES[idx]['terjemahan'] + 'e`'
#                     elif aksara_translate[-1].endswith('a'):
#                         if CLASS_NAMES[idx]['class_code'] in ['_h', '_hr', '_hy', '_s', '_sr', '_p', '_pr', '_py', '_P', '_Pr', '_Py']:
#                             aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan'] + 'a'
#                         else:
#                             aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
#                     else:
#                         aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 elif not CLASS_NAMES[idx]['terjemahan'].endswith(('u', 'A', 'I', 'E', 'U', 'O')):
#                     if len(aksara_list) >= 2:
#                         if extra_activation == True:
#                             aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'e`')
#                             extra_activation = False
#                         else:
#                             aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'a')
#                     else:
#                         aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'a')
#                 else:
#                     aksara_translate.append(CLASS_NAMES[idx]['terjemahan'])
#             elif aksara['letak'] == 'atas':
#                 if CLASS_NAMES[idx]['class_code'] == '_r1':
#                     aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 elif CLASS_NAMES[idx]['class_code'] == 'alt':
#                     if aksara_list[-1]['class_code'] == 'k':
#                         aksara_translate[-1] = 'kha'
#                     elif aksara_list[-1]['class_code'] == 'p':
#                         aksara_translate[-1] = 'fa'
#                     elif aksara_list[-1]['class_code'] == 'd':
#                         aksara_translate[-1] = 'dza'
#                     elif aksara_list[-1]['class_code'] == 'g':
#                         aksara_transate[-1] = 'gha'
#                     elif aksara_list[-1]['class_code'] == 'j':
#                         aksara_translate[-1] = 'za'
#                     else:
#                         continue
#                 elif CLASS_NAMES[idx]['class_code'] == 'ealt':
#                     if aksara_list[-1]['class_code'] == 'k':
#                         aksara_translate[-1] = 'khe'
#                     elif aksara_list[-1]['class_code'] == 'p':
#                         aksara_translate[-1] = 'fe'
#                     elif aksara_list[-1]['class_code'] == 'd':
#                         aksara_translate[-1] = 'dze'
#                     elif aksara_list[-1]['class_code'] == 'g':
#                         aksara_transate[-1] = 'ghe'
#                     elif aksara_list[-1]['class_code'] == 'j':
#                         aksara_translate[-1] = 'ze'
#                     else:
#                         continue
#                 elif CLASS_NAMES[idx]['class_code'] == 'e':
#                     if aksara_translate[-1].endswith(('a', 'i', 'u', 'e', 'o')):
#                         aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
#                     else:
#                         aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 elif CLASS_NAMES[idx]['class_code'] == 'eng':
#                     if aksara_translate[-1].endswith(('a', 'i', 'u', 'e', 'o')):
#                         aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
#                     else:
#                         aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 elif CLASS_NAMES[idx]['class_code'] == 'i':
#                     if aksara_translate[-1].endswith(('a', 'i', 'u', 'e', 'o')):
#                         aksara_translate[-1] = aksara_translate[-1][:-1] + CLASS_NAMES[idx]['terjemahan']
#                     else:
#                         aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 elif CLASS_NAMES[idx]['class_code'] == 'ng':
#                     aksara_translate[-1] = aksara_translate[-1] + CLASS_NAMES[idx]['terjemahan']
#                 else:
#                     continue
#             elif aksara['letak'] == 'bawah':
#                 if 'bawah' in CLASS_NAMES[idx]['letak']:
#                     aksara_list.append(CLASS_NAMES[idx])
#                     if aksara_translate[-1].endswith('e`'):
#                         aksara_translate[-1] = aksara_translate[-1][:-2]
#                         aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'e`')
#                     else:
#                         aksara_translate[-1] = aksara_translate[-1][:-1]
#                         if not CLASS_NAMES[idx]['terjemahan'].endswith(('a', 'i', 'u', 'e', 'o')):
#                             aksara_translate.append(CLASS_NAMES[idx]['terjemahan'] + 'a')
#                         else:
#                             aksara_translate.append(CLASS_NAMES[idx]['terjemahan'])
#                 else:
#                     continue
#         for aksara in aksara_translate:
#             translate = translate + aksara
#         translate = translate + '\n'
#     return translate

# @app.route('/translate', methods=['POST'])
# def translate_image():
#     # Check if an image file is in the request
#     if 'image' not in request.files:
#         return jsonify({'error': 'No image file provided'}), 400

#     file = request.files['image']

#     # Check if the file is empty
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400

#     if file:
#         filestr = file.read()
#         npimg = np.frombuffer(filestr, np.uint8)
#         img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

#         processed_data = process_image(img)
#         translate_result = translate_hasil_scan(processed_data)
        
#         # translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

#         # Return the result as JSON
#         return jsonify({'translation': translate_result})

#     return jsonify({'error': 'An unknown error occurred'}), 500

# if __name__ == '__main__':
#     # Run the app on localhost, port 5000
#     app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)






# import cv2
# import numpy as np
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# from ultralytics import YOLO
# import os

# # Initialize Flask app
# app = Flask(__name__)
# # Enable CORS to allow requests from your Flutter web app
# CORS(app)
# model = YOLO("best.pt")

# # Create an 'uploads' directory if it doesn't exist                                                                            
# if not os.path.exists('uploads'):
#     os.makedirs('uploads')

# def process_image(img):
#     """
#     This function contains the core logic from your notebook to process an image
#     and return structured line data.
#     """
#     img_height = img.shape[0]
#     results = model.predict(img)
#     result = results[0]

#     # 1. Store all detections
#     detections = []
#     for box in result.boxes:
#         x1, y1, x2, y2 = [int(c) for c in box.xyxy[0].tolist()]
#         class_id = int(box.cls[0])
#         class_name = result.names[class_id]
#         detections.append({
#             'class_name': class_name,
#             'bbox': [x1, y1, x2, y2]
#         })

#     if not detections:
#         return "No objects detected."

#     # 2. Group detections into lines
#     lines = []
#     detections.sort(key=lambda d: d['bbox'][1])
#     current_line = [detections[0]]
#     for det in detections[1:]:
#         avg_line_y_center = sum((d['bbox'][1] + d['bbox'][3]) / 2 for d in current_line) / len(current_line)
#         det_y_center = (det['bbox'][1] + det['bbox'][3]) / 2
#         avg_line_height = sum(d['bbox'][3] - d['bbox'][1] for d in current_line) / len(current_line)
#         tolerance = max(avg_line_height * 0.5, img_height * 0.02)

#         if abs(det_y_center - avg_line_y_center) < tolerance:
#             current_line.append(det)
#         else:
#             lines.append(current_line)
#             current_line = [det]
#     lines.append(current_line)

#     # 3. Structure the lines and format the final text
#     final_text_output = []
#     for i, line in enumerate(lines):
#         line.sort(key=lambda d: d['bbox'][0])
#         used_indices = set()
#         structured_line = []
#         for j in range(len(line)):
#             if j in used_indices: continue
#             base_char = line[j]
#             base_bbox = base_char['bbox']
#             used_indices.add(j)
#             above_chars, below_chars = [], []
#             for k in range(len(line)):
#                 if k in used_indices: continue
#                 other_char = line[k]
#                 other_bbox = other_char['bbox']
#                 is_overlapping_horizontally = (base_bbox[0] < other_bbox[2] and base_bbox[2] > other_bbox[0])
#                 if is_overlapping_horizontally:
#                     if other_bbox[3] < base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2:
#                         above_chars.append(other_char)
#                         used_indices.add(k)
#                     elif other_bbox[1] > base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2:
#                         below_chars.append(other_char)
#                         used_indices.add(k)

#             char_group = {
#                 'base': base_char['class_name'],
#                 'above': [c['class_name'] for c in sorted(above_chars, key=lambda d: d['bbox'][0])],
#                 'below': [c['class_name'] for c in sorted(below_chars, key=lambda d: d['bbox'][0])],
#                 'x_pos': base_char['bbox'][0]
#             }
#             structured_line.append(char_group)

#         structured_line.sort(key=lambda g: g['x_pos'])

#         line_text_parts = []
#         for group in structured_line:
#             text = group['base']
#             if group['above']:
#                 text += f" (Above: {', '.join(group['above'])})"
#             if group['below']:
#                 text += f" (Below: {', '.join(group['below'])})"
#             line_text_parts.append(text)

#         final_text_output.append(" ".join(line_text_parts))

#     return "\n".join(final_text_output)

# @app.route('/translate', methods=['POST'])
# def translate_image():
#     # Check if an image file is in the request
#     if 'image' not in request.files:
#         return jsonify({'error': 'No image file provided'}), 400

#     file = request.files['image']

#     # Check if the file is empty
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400

#     if file:
#         filestr = file.read()
#         npimg = np.frombuffer(filestr, np.uint8)
#         img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

#         processed_data = process_image(img)
        
#         # translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

#         # Return the result as JSON
#         return jsonify({'translation': processed_data})

#     return jsonify({'error': 'An unknown error occurred'}), 500

# if __name__ == '__main__':
#     # Run the app on localhost, port 5000
#     app.run(host='0.0.0.0', port=5000, debug=True)





# import cv2
# import numpy as np
# from flask import Flask, request, jsonify
# from flask_cors import CORS
# from ultralytics import YOLO
# import os

# # Initialize Flask app
# app = Flask(__name__)
# # Enable CORS to allow requests from your Flutter web app
# CORS(app)
# model = YOLO("best.pt")

# # Create an 'uploads' directory if it doesn't exist                                                                            
# if not os.path.exists('uploads'):
#     os.makedirs('uploads')

# def process_image(img):
#     """
#     This function contains the core logic from your notebook to process an image
#     and return structured line data.
#     """
#     img_height = img.shape[0]
#     results = model.predict(img)
#     result = results[0]

#     # 1. Store all detections
#     detections = []
#     for box in result.boxes:
#         x1, y1, x2, y2 = [int(c) for c in box.xyxy[0].tolist()]
#         class_id = int(box.cls[0])
#         class_name = result.names[class_id]
#         detections.append({
#             'class_name': class_name,
#             'bbox': [x1, y1, x2, y2]
#         })

#     # 2. Group detections into lines
#     lines = []
#     if detections:
#         detections.sort(key=lambda d: d['bbox'][1])
#         current_line = [detections[0]]
#         for det in detections[1:]:
#             avg_line_y_center = sum((d['bbox'][1] + d['bbox'][3]) / 2 for d in current_line) / len(current_line)
#             det_y_center = (det['bbox'][1] + det['bbox'][3]) / 2
#             avg_line_height = sum(d['bbox'][3] - d['bbox'][1] for d in current_line) / len(current_line)
#             tolerance = max(avg_line_height * 0.5, img_height * 0.02)

#             if abs(det_y_center - avg_line_y_center) < tolerance:
#                 current_line.append(det)
#             else:
#                 lines.append(current_line)
#                 current_line = [det]
#         lines.append(current_line)

#     # 3. Structure the lines
#     output_lines = []
#     for i, line in enumerate(lines):
#         line.sort(key=lambda d: d['bbox'][0])
#         used_indices = set()
#         structured_line = []
#         for j in range(len(line)):
#             if j in used_indices: continue
#             base_char = line[j]
#             base_bbox = base_char['bbox']
#             used_indices.add(j)
#             above_chars, below_chars = [], []
#             for k in range(len(line)):
#                 if k in used_indices: continue
#                 other_char = line[k]
#                 other_bbox = other_char['bbox']
#                 is_overlapping_horizontally = (base_bbox[0] < other_bbox[2] and base_bbox[2] > other_bbox[0])
#                 if is_overlapping_horizontally:
#                     if other_bbox[3] < base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2:
#                         above_chars.append(other_char)
#                         used_indices.add(k)
#                     elif other_bbox[1] > base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2:
#                         below_chars.append(other_char)
#                         used_indices.add(k)
#             char_group = {
#                 'base': base_char['class_name'],
#                 'above': [c['class_name'] for c in sorted(above_chars, key=lambda d: d['bbox'][0])],
#                 'below': [c['class_name'] for c in sorted(below_chars, key=lambda d: d['bbox'][0])],
#                 'x_pos': base_char['bbox'][0]
#             }
#             structured_line.append(char_group)

#         structured_line.sort(key=lambda g: g['x_pos'])
#         output_lines.append(structured_line)

#     return output_lines

# @app.route('/translate', methods=['POST'])
# def translate_image():
#     # Check if an image file is in the request
#     if 'image' not in request.files:
#         return jsonify({'error': 'No image file provided'}), 400

#     file = request.files['image']

#     # Check if the file is empty
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400

#     if file:
#         filestr = file.read()
#         npimg = np.frombuffer(filestr, np.uint8)
#         img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

#         processed_data = process_image(img)
        
#         # translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

#         # Return the result as JSON
#         return jsonify({'translation': processed_data})

#     return jsonify({'error': 'An unknown error occurred'}), 500

# if __name__ == '__main__':
#     # Run the app on localhost, port 5000
#     app.run(host='0.0.0.0', port=5000, debug=True)







# from flask import Flask, request, jsonify
# import os

# # Initialize the Flask application
# app = Flask(__name__)

# # Define the directory to save uploaded images
# UPLOAD_FOLDER = 'uploads'
# if not os.path.exists(UPLOAD_FOLDER):
#     os.makedirs(UPLOAD_FOLDER)

# app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# @app.route('/translate', methods=['POST'])
# def translate_image():
#     # Check if an image file is part of the request
#     if 'image' not in request.files:
#         return jsonify({'error': 'No image file provided'}), 400

#     file = request.files['image']

#     # Check if the file has a name
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400

#     if file:
#         # Save the file to the server
#         filename = os.path.join(app.config['UPLOAD_FOLDER'], 'received_image.png')
#         file.save(filename)

#         # --- Placeholder for your computation/model processing ---
#         # For now, we just return a fixed string.
#         # In the future, you can load the image using OpenCV or PIL,
#         # process it, and generate the actual result.
#         processed_text = "This is the recognized text from the image."
#         # ---------------------------------------------------------

#         return jsonify({'translation': processed_text})

#     return jsonify({'error': 'An unknown error occurred'}), 500

# if __name__ == '__main__':
#     # Run the app, making it accessible from the network (and the emulator)
#     # Use host='0.0.0.0' to allow connections from any IP address.
#     app.run(host='0.0.0.0', port=5000, debug=True)



# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import os

# # Initialize Flask app
# app = Flask(__name__)
# # Enable CORS to allow requests from your Flutter web app
# CORS(app)

# # Create an 'uploads' directory if it doesn't exist
# if not os.path.exists('uploads'):
#     os.makedirs('uploads')

# @app.route('/translate', methods=['POST'])
# def translate_image():
#     # Check if an image file is in the request
#     if 'image' not in request.files:
#         return jsonify({'error': 'No image file provided'}), 400

#     file = request.files['image']

#     # Check if the file is empty
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'}), 400

#     if file:
#         # You can save the file for debugging if you want
#         # filename = os.path.join('uploads', file.filename)
#         # file.save(filename)

#         # --- Placeholder for your Deep Learning Model ---
#         # In a real application, you would load your model here,
#         # process the image (file), and get the real translation.
#         # For now, we just return a fixed result.
        
#         translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

#         # Return the result as JSON
#         return jsonify({'translation': translation_result})

#     return jsonify({'error': 'An unknown error occurred'}), 500

# if __name__ == '__main__':
#     # Run the app on localhost, port 5000
#     app.run(host='0.0.0.0', port=5000, debug=True)
