import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'result_page.dart'; // We will create this file next

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator Aksara Jawa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: const TranslatorDesktopPage(),
    );
  }
}

class TranslatorDesktopPage extends StatefulWidget {
  const TranslatorDesktopPage({super.key});

  @override
  State<TranslatorDesktopPage> createState() => _TranslatorDesktopPageState();
}

class _TranslatorDesktopPageState extends State<TranslatorDesktopPage> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';

  void _translate() {
    setState(() {
      if (_textController.text.toLowerCase() == 'selamat datang') {
        _translatedText = 'ꦱꦼꦭꦩꦠ꧀ꦢꦠꦁ';
      } else if (_textController.text.isEmpty) {
        _translatedText = 'ꦱꦸꦒꦼꦁꦫꦮꦸꦃ';
      } else {
        _translatedText = 'ꦲꦱꦶꦭ꧀ꦠꦂꦗꦼꦩꦲꦤ꧀';
      }
    });
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        // Navigate to the result page with the image path
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(imagePath: image.path),
          ),
        );
      }
    } catch (e) {
      // Handle potential errors, e.g., if the user denies permissions
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memilih gambar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1800,
            maxHeight: 800,
          ),
          child: Card(
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                children: [
                  _buildInputSection(),
                  _buildOutputSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00A3FF), Color(0xFF0085FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Terjemahkan ke Aksara Jawa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _textController,
            onChanged: (text) => _translate(),
            maxLines: 4,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Ketik teks di sini...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputSection() {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    _translatedText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansJavanese(
                      fontSize: 32,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.photo_library_outlined, // Changed icon
                  label: 'Pilih Gambar', // Changed label
                  onPressed: _pickImageFromGallery, // Changed function
                ),
                _buildActionButton(
                  icon: Icons.volume_up_outlined,
                  label: 'Dengarkan',
                  onPressed: () {
                    // TODO: Tambahkan logika untuk text-to-speech
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue.shade800,
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}


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