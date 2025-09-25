import cv2
import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS
from ultralytics import YOLO
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
    """
    This function contains the core logic from your notebook to process an image
    and return structured line data.
    """
    img_height = img.shape[0]
    results = model.predict(img)
    result = results[0]

    # 1. Store all detections
    detections = []
    for box in result.boxes:
        x1, y1, x2, y2 = [int(c) for c in box.xyxy[0].tolist()]
        class_id = int(box.cls[0])
        class_name = result.names[class_id]
        detections.append({
            'class_name': class_name,
            'bbox': [x1, y1, x2, y2]
        })

    # 2. Group detections into lines
    lines = []
    if detections:
        detections.sort(key=lambda d: d['bbox'][1])
        current_line = [detections[0]]
        for det in detections[1:]:
            avg_line_y_center = sum((d['bbox'][1] + d['bbox'][3]) / 2 for d in current_line) / len(current_line)
            det_y_center = (det['bbox'][1] + det['bbox'][3]) / 2
            avg_line_height = sum(d['bbox'][3] - d['bbox'][1] for d in current_line) / len(current_line)
            tolerance = max(avg_line_height * 0.5, img_height * 0.02)

            if abs(det_y_center - avg_line_y_center) < tolerance:
                current_line.append(det)
            else:
                lines.append(current_line)
                current_line = [det]
        lines.append(current_line)

    # 3. Structure the lines
    output_lines = []
    for i, line in enumerate(lines):
        line.sort(key=lambda d: d['bbox'][0])
        used_indices = set()
        structured_line = []
        for j in range(len(line)):
            if j in used_indices: continue
            base_char = line[j]
            base_bbox = base_char['bbox']
            used_indices.add(j)
            above_chars, below_chars = [], []
            for k in range(len(line)):
                if k in used_indices: continue
                other_char = line[k]
                other_bbox = other_char['bbox']
                is_overlapping_horizontally = (base_bbox[0] < other_bbox[2] and base_bbox[2] > other_bbox[0])
                if is_overlapping_horizontally:
                    if other_bbox[3] < base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2:
                        above_chars.append(other_char)
                        used_indices.add(k)
                    elif other_bbox[1] > base_bbox[1] + (base_bbox[3] - base_bbox[1]) / 2:
                        below_chars.append(other_char)
                        used_indices.add(k)
            char_group = {
                'base': base_char['class_name'],
                'above': [c['class_name'] for c in sorted(above_chars, key=lambda d: d['bbox'][0])],
                'below': [c['class_name'] for c in sorted(below_chars, key=lambda d: d['bbox'][0])],
                'x_pos': base_char['bbox'][0]
            }
            structured_line.append(char_group)

        structured_line.sort(key=lambda g: g['x_pos'])
        output_lines.append(structured_line)

    return output_lines

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
        
        # translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

        # Return the result as JSON
        return jsonify({'translation': processed_data})

    return jsonify({'error': 'An unknown error occurred'}), 500

if __name__ == '__main__':
    # Run the app on localhost, port 5000
    app.run(host='0.0.0.0', port=5000, debug=True)
