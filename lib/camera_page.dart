import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'result_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  String? _cameraError;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _controller = CameraController(_cameras![0], ResolutionPreset.high);
        await _controller!.initialize();
        if (!mounted) return;
        setState(() {
          _isCameraInitialized = true;
        });
      } else {
        setState(() {
          _cameraError = "Tidak ada kamera yang ditemukan.";
        });
      }
    } on CameraException catch (e) {
      setState(() {
        _cameraError =
        "Gagal mengakses kamera: ${e.description}\n\nPastikan Anda telah memberikan izin kamera pada browser.";
      });
    } catch (e) {
      setState(() {
        _cameraError = "Terjadi kesalahan: $e";
      });
    }
  }

  void _navigateToResultPage(String imagePath) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(imagePath: imagePath),
      ),
    );
  }

  Future<void> _onTakePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    try {
      final XFile file = await _controller!.takePicture();
      _navigateToResultPage(file.path);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onPickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _navigateToResultPage(image.path);
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildCameraView(),
    );
  }

  Widget _buildCameraView() {
    if (_cameraError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _cameraError!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Center(child: CameraPreview(_controller!)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gallery Button
                IconButton(
                  onPressed: _onPickFromGallery,
                  icon: const Icon(Icons.photo_library,
                      color: Colors.white, size: 36),
                ),
                // Capture Button
                IconButton(
                  onPressed: _onTakePicture,
                  icon:
                  const Icon(Icons.camera, color: Colors.white, size: 64),
                ),
                // Back Button
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 36),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'result_page.dart';
//
// class CameraPage extends StatefulWidget {
//   const CameraPage({super.key});
//
//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//   CameraController? _controller;
//   List<CameraDescription>? _cameras;
//   bool _isCameraInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     _cameras = await availableCameras();
//     if (_cameras != null && _cameras!.isNotEmpty) {
//       _controller = CameraController(_cameras![0], ResolutionPreset.high);
//       await _controller!.initialize();
//       if (!mounted) return;
//       setState(() {
//         _isCameraInitialized = true;
//       });
//     }
//   }
//
//   void _navigateToResultPage(String imagePath) {
//     // Use pushReplacement to avoid stacking camera pages
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultPage(imagePath: imagePath),
//       ),
//     );
//   }
//
//   Future<void> _onTakePicture() async {
//     if (_controller == null || !_controller!.value.isInitialized) {
//       return;
//     }
//     try {
//       final XFile file = await _controller!.takePicture();
//       _navigateToResultPage(file.path);
//     } catch (e) {
//       // Handle error
//     }
//   }
//
//   Future<void> _onPickFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         _navigateToResultPage(image.path);
//       }
//     } catch (e) {
//       // Handle error
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: _isCameraInitialized
//           ? Stack(
//         children: [
//           Center(child: CameraPreview(_controller!)),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 30),
//               color: Colors.black.withOpacity(0.5),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Gallery Button
//                   IconButton(
//                     onPressed: _onPickFromGallery,
//                     icon: const Icon(Icons.photo_library,
//                         color: Colors.white, size: 36),
//                   ),
//                   // Capture Button
//                   IconButton(
//                     onPressed: _onTakePicture,
//                     icon: const Icon(Icons.camera,
//                         color: Colors.white, size: 64),
//                   ),
//                   // Back Button
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.arrow_back,
//                         color: Colors.white, size: 36),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
