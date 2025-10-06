import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final String imagePath;

  const ResultPage({super.key, required this.imagePath});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _status = 'Mengirim gambar ke server...';
  String? _translatedText;
  String? _errorMessage;
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _loadImageAndTranslate();
  }

  Future<void> _loadImageAndTranslate() async {
    try {
      // For Flutter Web, imagePath is a URL. We need to fetch the bytes.
      final response = await http.get(Uri.parse(widget.imagePath));
      if (response.statusCode == 200) {
        setState(() {
          _imageData = response.bodyBytes;
        });
        _uploadImage(_imageData!);
      } else {
        throw Exception('Gagal memuat gambar');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error memuat gambar: $e';
      });
    }
  }

  Future<void> _uploadImage(Uint8List imageBytes) async {
    // For Flutter Web, use 'localhost'. For Android emulator, use '10.0.2.2'.
    var uri = Uri.parse('http://localhost:5000/translate');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'upload.jpg',
      ),
    );

    try {
      setState(() {
        _status = 'Memproses gambar di server...';
      });

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          // Handle the case where translation is an array/list
          var translation = responseData['translation'];
          if (translation is List) {
            // Convert the structured data to a readable string
            _translatedText = _formatStructuredTranslation(translation);
          } else {
            _translatedText = translation.toString();
          }
          _status = 'Terjemahan berhasil!';
        });
      } else {
        setState(() {
          _errorMessage =
          'Gagal menerjemahkan. Server merespon: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
        'Terjadi kesalahan jaringan. Pastikan server Flask berjalan.\nError: $e';
      });
    }
  }

  String _formatStructuredTranslation(List<dynamic> lines) {
    StringBuffer result = StringBuffer();
    
    for (int i = 0; i < lines.length; i++) {
      if (lines[i] is List) {
        List<dynamic> line = lines[i];
        StringBuffer lineText = StringBuffer();
        
        for (var charGroup in line) {
          if (charGroup is Map) {
            // Handle above characters
            if (charGroup['above'] != null && charGroup['above'].isNotEmpty) {
              lineText.write(charGroup['above'].join(''));
            }
            
            // Handle base character
            if (charGroup['base'] != null) {
              lineText.write(charGroup['base']);
            }
            
            // Handle below characters
            if (charGroup['below'] != null && charGroup['below'].isNotEmpty) {
              lineText.write(charGroup['below'].join(''));
            }
          }
        }
        
        result.write(lineText.toString());
        if (i < lines.length - 1) {
          result.write('\n'); // Add newline between lines
        }
      }
    }
    
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Terjemahan'),
        backgroundColor: const Color(0xFF0085FF),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Gambar yang Dipilih:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Display the selected image
              _imageData == null
                  ? const CircularProgressIndicator()
                  : ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 500,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(_imageData!),
                ),
              ),
              const SizedBox(height: 30),
              _buildResultWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultWidget() {
    if (_errorMessage != null) {
      return Text(
        _errorMessage!,
        style: const TextStyle(color: Colors.red, fontSize: 16),
        textAlign: TextAlign.center,
      );
    }

    if (_translatedText == null) {
      return Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            _status,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      );
    }

    return Column(
      children: [
        Text(
          'Hasil Terjemahan:',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _translatedText!,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansJavanese(
              fontSize: 32,
              color: Colors.blue[900],
            ),
          ),
        ),
      ],
    );
  }
}


// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class ResultPage extends StatefulWidget {
//   final String imagePath;
//   const ResultPage({super.key, required this.imagePath});
//
//   @override
//   State<ResultPage> createState() => _ResultPageState();
// }
//
// class _ResultPageState extends State<ResultPage> {
//   String _translatedText = 'Menerjemahkan...';
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _uploadAndTranslateImage();
//   }
//
//   Future<void> _uploadAndTranslateImage() async {
//     // IMPORTANT: Replace with your computer's IP address.
//     // For Android Emulator, use 10.0.2.2
//     // For a physical device on the same Wi-Fi, use your computer's local IP (e.g., 192.168.1.10)
//     const String serverUrl = 'http://10.0.2.2:5000/translate';
//
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
//       request.files
//           .add(await http.MultipartFile.fromPath('image', widget.imagePath));
//
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final decodedResponse = jsonDecode(responseBody);
//         setState(() {
//           _translatedText = decodedResponse['translation'];
//         });
//       } else {
//         setState(() {
//           _translatedText = 'Gagal menerjemahkan. Coba lagi.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _translatedText = 'Error: Tidak dapat terhubung ke server.';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 1800, maxHeight: 800),
//           child: Card(
//             elevation: 10,
//             shadowColor: Colors.black.withOpacity(0.2),
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Column(
//                 children: [
//                   // Section to display the image
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: FileImage(File(widget.imagePath)),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Section for translation result
//                   _buildOutputSection(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOutputSection() {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Hasil Terjemahan:',
//             style: TextStyle(color: Colors.grey[600], fontSize: 16),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.blue[50],
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : Text(
//               _translatedText,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.notoSansJavanese(
//                 fontSize: 32,
//                 color: Colors.blue[900],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }