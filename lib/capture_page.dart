import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'config.dart'; // Import the new config file

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  File? _imageFile;
  String? _translation;
  bool _isLoading = false;
  String? _error;
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadAndTranslate(File imageFile) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _translation = null;
    });

    try {
      // 10.0.2.2 is the special address for the Android emulator
      // to access the host machine's localhost.
      var uri = Uri.parse('$serverUrl/translate'); // var uri = Uri.parse('http://10.0.2.2:5000/translate');
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _translation = responseData['translation'];
        });
      } else {
        setState(() {
          _error = 'Server Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to connect to server: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        setState(() {
          _imageFile = image;
        });
        await _uploadAndTranslate(image);
      }
    } catch (e) {
      setState(() {
        _error = "Failed to pick image: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131629),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _imageFile == null
                    ? Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Icon(
                    Icons.image_search,
                    size: 100,
                    color: Colors.grey,
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.file(
                    _imageFile!,
                    height: 450,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                if (_isLoading) const CircularProgressIndicator(),
                if (_error != null)
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                if (_translation != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _translation!,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
//
// class CapturePage extends StatelessWidget {
//   const CapturePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Capture Page',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }
