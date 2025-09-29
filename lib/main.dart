import 'package:flutter/material.dart';
import 'home_page.dart';
import 'typing_page.dart';
import 'audio_page.dart';
import 'capture_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TypingPage(),
    AudioPage(),
    CapturePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF131629),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aksara Translator'),
          backgroundColor: const Color(0xFF131629),
          elevation: 0,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_alt_outlined),
              label: 'Typing',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic_none_outlined),
              label: 'Audio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined),
              label: 'Capture',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFF131629),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'home_page.dart';
// import 'typing_page.dart';
// import 'audio_page.dart';
// import 'capture_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     HomePage(),
//     TypingPage(),
//     AudioPage(),
//     CapturePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF131629),
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         body: Center(
//           child: _widgetOptions.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.keyboard_alt_outlined),
//               label: 'Typing',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.mic_none_outlined),
//               label: 'Audio',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.camera_alt_outlined),
//               label: 'Capture',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           backgroundColor: const Color(0xFF131629),
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//         ),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translator App',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Colors.transparent,
//         primarySwatch: Colors.blue,
//         fontFamily: 'Roboto',
//       ),
//       home: const TranslatorHomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class TranslatorHomeScreen extends StatefulWidget {
//   const TranslatorHomeScreen({super.key});
//
//   @override
//   State<TranslatorHomeScreen> createState() => _TranslatorHomeScreenState();
// }
//
// class _TranslatorHomeScreenState extends State<TranslatorHomeScreen> {
//   int _selectedIndex = 1;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF5263FF), Color(0xFF3343D9)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: _buildMainCard(),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   width: 135,
//                   height: 5,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F243F),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Column(
//         children: [
//           _buildTopBar(),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: _buildTranslationCard(
//                       'Indonesia',
//                       'Serangan terhadap warga Asia New York baru-baru ini menyebabkan empat kematian. Yao Pan Ma, seorang imigran Cina',
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: _buildTranslationCard(
//                       'English',
//                       'Attacks against Asian New Yorkers have recently led to four deaths. Yao Pan Ma, a Chinese immigrant,',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           _buildLanguageSelector(),
//           _buildCustomBottomNavBar(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopBar() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: 80,
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: const Color(0xFF262D4D),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF3D52F8),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.wb_sunny,
//                       size: 18, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.menu, color: Colors.white),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTranslationCard(String language, String text) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF262D4D),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             language,
//             style: TextStyle(color: Colors.grey[400], fontSize: 14),
//           ),
//           const SizedBox(height: 12),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                   color: Colors.white, fontSize: 18, height: 1.5),
//             ),
//           ),
//           Row(
//             children: [
//               Icon(Icons.copy_outlined, color: Colors.grey[400], size: 22),
//               const SizedBox(width: 16),
//               Icon(Icons.share_outlined, color: Colors.grey[400], size: 22),
//               const Spacer(),
//               Icon(Icons.volume_up_outlined,
//                   color: Colors.grey[400], size: 22),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLanguageSelector() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('Indonesia',
//               style: TextStyle(color: Colors.white, fontSize: 16)),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: const BoxDecoration(
//               color: Color(0xFF3D52F8),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.swap_horiz, color: Colors.white, size: 24),
//           ),
//           const Text('English',
//               style: TextStyle(color: Colors.white, fontSize: 16)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCustomBottomNavBar() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(Icons.home, 'Home', 0),
//           _buildNavItem(Icons.keyboard_alt_outlined, 'Typing', 1),
//           _buildNavItem(Icons.mic_none_outlined, 'Audio', 2),
//           _buildNavItem(Icons.camera_alt_outlined, 'Capture', 3),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = _selectedIndex == index;
//     final color = isSelected ? const Color(0xFF3D52F8) : Colors.grey[400];
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: color, size: 28),
//           const SizedBox(height: 4),
//           Text(label, style: TextStyle(color: color, fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }




// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Translator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.dark,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   File? _imageFile;
//   String _translation = '';
//   bool _isLoading = false;
//   final ImagePicker _picker = ImagePicker();
//
//   // Fungsi untuk memilih gambar dari galeri
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//         _translation = ''; // Reset terjemahan sebelumnya
//       });
//       _uploadImage(); // Langsung upload setelah gambar dipilih
//     }
//   }
//
//   // Fungsi untuk mengunggah gambar ke server
//   Future<void> _uploadImage() async {
//     if (_imageFile == null) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     // URL server. 10.0.2.2 adalah alamat khusus untuk mengakses localhost
//     // dari host machine (komputer Anda) melalui Android Emulator.
//     var uri = Uri.parse('http://10.0.2.2:5000/translate');
//     var request = http.MultipartRequest('POST', uri);
//     request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));
//
//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.body);
//         setState(() {
//           _translation = responseData['translation'];
//         });
//       } else {
//         setState(() {
//           _translation = 'Error: ${response.reasonPhrase}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _translation = 'Error connecting to server: $e';
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
//       appBar: AppBar(
//         title: const Text('Image Translator'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 if (_imageFile != null)
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12.0),
//                     child: Image.file(
//                       _imageFile!,
//                       height: 250,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 else
//                   Container(
//                     height: 250,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[800],
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     child: const Icon(
//                       Icons.image,
//                       size: 100,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 const SizedBox(height: 20),
//                 if (_isLoading)
//                   const CircularProgressIndicator()
//                 else if (_translation.isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.blueGrey[800],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       _translation,
//                       style: const TextStyle(fontSize: 20, color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _pickImage,
//         label: const Text('Pick Image'),
//         icon: const Icon(Icons.photo_library),
//       ),
//     );
//   }
// }




// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
//
// // IMPORTANT: Replace with your computer's IP address for a physical device,
// // or use 10.0.2.2 for the Android emulator.
// const String serverUrl = 'http://10.0.2.2:5000/translate';
//
// void main() {
//   runApp(const TranslatorApp());
// }
//
// class TranslatorApp extends StatelessWidget {
//   const TranslatorApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translator',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF121721),
//         bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: Color(0xFF1F2430),
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//       home: const MainScreen(),
//     );
//   }
// }
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 3; // Default to Capture screen
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     Center(child: Text('Home')),
//     Center(child: Text('Typing')),
//     Center(child: Text('Audio')),
//     CaptureScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.keyboard),
//             label: 'Typing',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.mic),
//             label: 'Audio',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.camera_alt),
//             label: 'Capture',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
//
// class CaptureScreen extends StatefulWidget {
//   const CaptureScreen({super.key});
//
//   @override
//   State<CaptureScreen> createState() => _CaptureScreenState();
// }
//
// class _CaptureScreenState extends State<CaptureScreen> {
//   File? _imageFile;
//   String? _translation;
//   bool _isLoading = false;
//   String? _error;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _translateImage(File imageFile) async {
//     setState(() {
//       _isLoading = true;
//       _error = null;
//       _translation = null;
//     });
//
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'image',
//           imageFile.path,
//         ),
//       );
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         final decoded = json.decode(responseBody);
//         setState(() {
//           _translation = decoded['translation'];
//         });
//       } else {
//         final responseBody = await response.stream.bytesToString();
//         setState(() {
//           _error = 'Server error: ${response.statusCode}\n$responseBody';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _error = 'Failed to connect to the server: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final pickedFile = await _picker.pickImage(source: source);
//       if (pickedFile != null) {
//         final image = File(pickedFile.path);
//         setState(() {
//           _imageFile = image;
//         });
//         await _translateImage(image);
//       }
//     } catch (e) {
//       setState(() {
//         _error = "Failed to pick image: $e";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Translation'),
//         backgroundColor: const Color(0xFF121721),
//         elevation: 0,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 if (_imageFile == null)
//                   const Text('Capture or select an image to translate.'),
//                 if (_imageFile != null)
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12.0),
//                         child: Image.file(_imageFile!),
//                       ),
//                       if (_translation != null)
//                         Positioned(
//                           bottom: 20,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.7),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               _translation!,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 const SizedBox(height: 20),
//                 if (_isLoading) const CircularProgressIndicator(),
//                 if (_error != null)
//                   Text(
//                     _error!,
//                     style: const TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: () => _pickImage(ImageSource.camera),
//                       icon: const Icon(Icons.camera),
//                       label: const Text('Camera'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: () => _pickImage(ImageSource.gallery),
//                       icon: const Icon(Icons.photo_library),
//                       label: const Text('Gallery'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'result_page.dart'; // We will create this file next
//
// void main() {
//   runApp(const TranslatorApp());
// }
//
// class TranslatorApp extends StatelessWidget {
//   const TranslatorApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translator Aksara Jawa',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
//       ),
//       home: const TranslatorDesktopPage(),
//     );
//   }
// }
//
// class TranslatorDesktopPage extends StatefulWidget {
//   const TranslatorDesktopPage({super.key});
//
//   @override
//   State<TranslatorDesktopPage> createState() => _TranslatorDesktopPageState();
// }
//
// class _TranslatorDesktopPageState extends State<TranslatorDesktopPage> {
//   final TextEditingController _textController = TextEditingController();
//   String _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';
//
//   void _translate() {
//     setState(() {
//       if (_textController.text.toLowerCase() == 'selamat datang') {
//         _translatedText = 'ꦱꦼꦭꦩꦠ꧀ꦢꦠꦁ';
//       } else if (_textController.text.isEmpty) {
//         _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';
//       } else {
//         _translatedText = 'ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀';
//       }
//     });
//   }
//
//   // Function to pick an image from the gallery
//   Future<void> _pickImageFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null && mounted) {
//         // Navigate to the result page with the image path
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ResultPage(imagePath: image.path),
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle potential errors, e.g., if the user denies permissions
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Gagal memilih gambar: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxWidth: 1800,
//             maxHeight: 800,
//           ),
//           child: Card(
//             elevation: 10,
//             shadowColor: Colors.black.withOpacity(0.2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Column(
//                 children: [
//                   _buildInputSection(),
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
//   Widget _buildInputSection() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF00A3FF), Color(0xFF0085FF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Terjemahkan ke Aksara Jawa',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _textController,
//             onChanged: (text) => _translate(),
//             maxLines: 4,
//             style: const TextStyle(color: Colors.white, fontSize: 18),
//             decoration: InputDecoration(
//               hintText: 'Ketik teks di sini...',
//               border: InputBorder.none,
//               hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOutputSection() {
//     return Expanded(
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hasil Terjemahan:',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     _translatedText,
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.notoSansJavanese(
//                       fontSize: 32,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildActionButton(
//                   icon: Icons.photo_library_outlined, // Changed icon
//                   label: 'Pilih Gambar', // Changed label
//                   onPressed: _pickImageFromGallery, // Changed function
//                 ),
//                 _buildActionButton(
//                   icon: Icons.volume_up_outlined,
//                   label: 'Dengarkan',
//                   onPressed: () {
//                     // TODO: Tambahkan logika untuk text-to-speech
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 20),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.blue.shade800,
//         backgroundColor: Colors.blue.shade50,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         textStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'camera_page.dart'; // Import the new camera page
//
// void main() {
//   runApp(const TranslatorApp());
// }
//
// class TranslatorApp extends StatelessWidget {
//   const TranslatorApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translator Aksara Jawa',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
//       ),
//       home: const TranslatorDesktopPage(),
//     );
//   }
// }
//
// class TranslatorDesktopPage extends StatefulWidget {
//   const TranslatorDesktopPage({super.key});
//
//   @override
//   State<TranslatorDesktopPage> createState() => _TranslatorDesktopPageState();
// }
//
// class _TranslatorDesktopPageState extends State<TranslatorDesktopPage> {
//   final TextEditingController _textController = TextEditingController();
//   String _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';
//
//   void _translate() {
//     setState(() {
//       if (_textController.text.toLowerCase() == 'selamat datang') {
//         _translatedText = 'ꦱꦼꦭꦩꦠ꧀ꦢꦠꦁ';
//       } else if (_textController.text.isEmpty) {
//         _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';
//       } else {
//         _translatedText = 'ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxWidth: 1800,
//             maxHeight: 800,
//           ),
//           child: Card(
//             elevation: 10,
//             shadowColor: Colors.black.withOpacity(0.2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Column(
//                 children: [
//                   _buildInputSection(),
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
//   Widget _buildInputSection() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF00A3FF), Color(0xFF0085FF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Terjemahkan ke Aksara Jawa',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _textController,
//             onChanged: (text) => _translate(),
//             maxLines: 4,
//             style: const TextStyle(color: Colors.white, fontSize: 18),
//             decoration: InputDecoration(
//               hintText: 'Ketik teks di sini...',
//               border: InputBorder.none,
//               hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildOutputSection() {
//     return Expanded(
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hasil Terjemahan:',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     _translatedText,
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.notoSansJavanese(
//                       fontSize: 32,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildActionButton(
//                   icon: Icons.camera_alt_outlined,
//                   label: 'Ambil Foto',
//                   onPressed: () {
//                     // Navigate to the camera page
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const CameraPage()),
//                     );
//                   },
//                 ),
//                 _buildActionButton(
//                   icon: Icons.volume_up_outlined,
//                   label: 'Dengarkan',
//                   onPressed: () {
//                     // TODO: Tambahkan logika untuk text-to-speech
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 20),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.blue.shade800,
//         backgroundColor: Colors.blue.shade50,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         textStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// void main() {
//   runApp(const TranslatorApp());
// }
//
// class TranslatorApp extends StatelessWidget {
//   const TranslatorApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translator Aksara Jawa',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         // Menggunakan font yang mendukung Aksara Jawa sebagai font default
//         textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
//       ),
//       home: const TranslatorDesktopPage(),
//     );
//   }
// }
//
// class TranslatorDesktopPage extends StatefulWidget {
//   const TranslatorDesktopPage({super.key});
//
//   @override
//   State<TranslatorDesktopPage> createState() => _TranslatorDesktopPageState();
// }
//
// class _TranslatorDesktopPageState extends State<TranslatorDesktopPage> {
//   // Controller untuk mengambil teks dari input field
//   final TextEditingController _textController = TextEditingController();
//   // State untuk menyimpan hasil terjemahan (contoh statis)
//   String _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ'; // Contoh: "Sugeng Rawuh"
//
//   void _translate() {
//     setState(() {
//       // Di sini Anda akan menambahkan logika translasi yang sebenarnya.
//       // Untuk saat ini, kita hanya menampilkan contoh.
//       if (_textController.text.toLowerCase() == 'selamat datang') {
//         _translatedText = 'ꦱꦼꦭꦩꦠ꧀ꦢꦠꦁ';
//       } else if (_textController.text.isEmpty) {
//         _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';
//       } else {
//         // Placeholder untuk teks lain
//         _translatedText = 'ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxWidth: 1800,//1400,//450, // Lebar maksimal agar tidak terlalu lebar di desktop
//             maxHeight: 800, // Tinggi maksimal
//           ),
//           child: Card(
//             elevation: 10,
//             shadowColor: Colors.black.withOpacity(0.2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Column(
//                 children: [
//                   // BAGIAN INPUT (ATAS - BIRU)
//                   _buildInputSection(),
//
//                   // BAGIAN OUTPUT (BAWAH - PUTIH)
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
//   // Widget untuk bagian input teks
//   Widget _buildInputSection() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF00A3FF), Color(0xFF0085FF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Terjemahkan ke Aksara Jawa',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _textController,
//             onChanged: (text) => _translate(),
//             maxLines: 4,
//             style: const TextStyle(color: Colors.white, fontSize: 18),
//             decoration: InputDecoration(
//               hintText: 'Ketik teks di sini...',
//               border: InputBorder.none,
//               hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget untuk bagian hasil terjemahan dan tombol aksi
//   Widget _buildOutputSection() {
//     return Expanded(
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Bubble untuk hasil terjemahan
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Hasil Terjemahan:',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     _translatedText,
//                     textAlign: TextAlign.center,
//                     // Gunakan GoogleFonts untuk menampilkan Aksara Jawa
//                     style: GoogleFonts.notoSansJavanese(
//                       fontSize: 32,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             // Tombol Aksi
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildActionButton(
//                   icon: Icons.camera_alt_outlined,
//                   label: 'Ambil Foto',
//                   onPressed: () {
//                     // TODO: Tambahkan logika untuk membuka kamera/galeri
//                   },
//                 ),
//                 _buildActionButton(
//                   icon: Icons.volume_up_outlined,
//                   label: 'Dengarkan',
//                   onPressed: () {
//                     // TODO: Tambahkan logika untuk text-to-speech
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget template untuk tombol aksi agar tidak duplikat kode
//   Widget _buildActionButton({
//     required IconData icon,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, size: 20),
//       label: Text(label),
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.blue.shade800,
//         backgroundColor: Colors.blue.shade50,
//         elevation: 0,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         textStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }