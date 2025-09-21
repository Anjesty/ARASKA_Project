from flask import Flask, request, jsonify
from flask_cors import CORS
import os

# Initialize Flask app
app = Flask(__name__)
# Enable CORS to allow requests from your Flutter web app
CORS(app)

# Create an 'uploads' directory if it doesn't exist
if not os.path.exists('uploads'):
    os.makedirs('uploads')

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
        # You can save the file for debugging if you want
        # filename = os.path.join('uploads', file.filename)
        # file.save(filename)

        # --- Placeholder for your Deep Learning Model ---
        # In a real application, you would load your model here,
        # process the image (file), and get the real translation.
        # For now, we just return a fixed result.
        
        translation_result = "ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀" # "Hasil Terjemahan"

        # Return the result as JSON
        return jsonify({'translation': translation_result})

    return jsonify({'error': 'An unknown error occurred'}), 500

if __name__ == '__main__':
    # Run the app on localhost, port 5000
    app.run(host='0.0.0.0', port=5000, debug=True)
