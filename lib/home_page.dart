import 'package:flutter/material.dart';
import 'javanese_guide_page.dart';
import 'javanese_history_page.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Stack(
        children: [
          // Background Image/Wallpaper - Fullscreen tanpa SafeArea
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wallpaper_batik_parang.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Dark overlay untuk membuat text lebih terbaca
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // Content dengan SafeArea
          SafeArea(
            child: Stack(
              children: [
                // Gambar Wayang Kiri Atas
                Positioned(
                  top: 20,
                  left: 150,
                  child: Opacity(
                    opacity: 0.65,
                    child: Image.asset(
                      'assets/images/circle.png',
                      width: 380,
                      height: 380,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Gambar Wayang Kanan (Tokoh Utama)
                Positioned(
                  top: 40,
                  right: -110,
                  child: Opacity(
                    opacity: 0.9,
                    child: Transform.flip(
                      flipX: true,
                      child: Image.asset(
                        'assets/images/wayang.png',
                        width: 360,
                        height: 400,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Ornamen Batik Kiri
                Positioned(
                  top: 120,
                  left: 170,
                  child: Opacity(
                    opacity: 0.9,
                    child: Image.asset(
                      'assets/images/gamelan.png',
                      width: 350,
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Ornamen Batik Kanan Bawah
                Positioned(
                  bottom: 200,
                  right: -30,
                  child: Opacity(
                    opacity: 0.9,
                    child: Image.asset(
                      'assets/images/wayang.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Main content dengan LayoutBuilder
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          children: [
                            // Bagian Atas - Welcome message
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(height: 20),
                                  Text(
                                    'Selamat Datang!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 8,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Siap menerjemahkan aksara Jawa\nhari ini?',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      height: 1.5,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 4,
                                          color: Colors.black45,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Spacer untuk mendorong banner ke bawah
                            // UBAH NILAI INI untuk mengatur jarak dari atas
                            SizedBox(height: constraints.maxHeight * 0.3), // 30% dari tinggi layar
                            // Atau gunakan nilai tetap seperti:
                            // SizedBox(height: 200), // 200 pixels dari welcome message

                            // Banners di bagian bawah
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Stack(
                                children: [
                                  Column(
                                    children: const [
                                      _GuideBanner(),
                                      SizedBox(height: 24),
                                      _HistoryBanner(),
                                    ],
                                  ),
                                  // Gambar Gamelan di tengah (antara dua banner)
                                  Positioned(
                                    bottom: -30,
                                    right: 0,
                                    child: Opacity(
                                      opacity: 0.1,
                                      child: Image.asset(
                                        'assets/images/gamelan.png',
                                        width: 380,
                                        height: 320,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Padding bawah untuk bottom navigation
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Ornamen dekoratif bawah
                Positioned(
                  top: 150,
                  left: -120,
                  child: Opacity(
                    opacity: 0.9,
                    child: Transform.rotate(
                      angle: -30 * math.pi / 180,
                      child: Image.asset(
                        'assets/images/wayang_panggon.png',
                        width: 300,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideBanner extends StatelessWidget {
  const _GuideBanner();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E2A4A).withOpacity(0.9),
              const Color(0xFF0F1729).withOpacity(0.85),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.blue.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container dengan gradient
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.withOpacity(0.4),
                    Colors.blue.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
                size: 44,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Panduan Lengkap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Aturan Aksara Jawa',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Text(
                        'Mulai belajar sekarang!',
                        style: TextStyle(
                          color: Color(0xFF5DADE2),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF5DADE2),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryBanner extends StatelessWidget {
  const _HistoryBanner();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A1E4A).withOpacity(0.9),
              const Color(0xFF170F29).withOpacity(0.85),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.purple.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container dengan gradient
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.withOpacity(0.4),
                    Colors.purple.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.purple.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.history_edu_rounded,
                color: Colors.purple,
                size: 44,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sejarah Aksara Jawa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Jelajahi asal-usulnya',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Text(
                        'Lihat selengkapnya',
                        style: TextStyle(
                          color: Color(0xFFBB8FCE),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFBB8FCE),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
// import 'javanese_history_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0E27),
//       body: Stack(
//         children: [
//           // Background Image/Wallpaper - Fullscreen tanpa SafeArea
//           Positioned.fill(
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/wallpaper_batik.jpeg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//
//           // Dark overlay untuk membuat text lebih terbaca
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.7),
//                     Colors.black.withOpacity(0.5),
//                     Colors.black.withOpacity(0.8),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Content dengan SafeArea
//           SafeArea(
//             child: Stack(
//               children: [
//                 // Gambar Wayang Kiri Atas
//                 Positioned(
//                   top: -20,
//                   left: -30,
//                   child: Opacity(
//                     opacity: 0.9,
//                     child: Image.asset(
//                       'assets/images/wayang.png',
//                       width: 180,
//                       height: 180,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Gambar Wayang Kanan (Tokoh Utama)
//                 Positioned(
//                   top: 40,
//                   right: -160,
//                   child: Opacity(
//                     opacity: 0.9,
//                     child: Transform.flip(
//                       flipX: true, // Mirror horizontal (kanan-kiri)
//                       child: Image.asset(
//                         'assets/images/wayang.png',
//                         width: 360,
//                         height: 400,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Ornamen Batik Kiri
//                 Positioned(
//                   top: 120,
//                   left: -40,
//                   child: Opacity(
//                     opacity: 0.9,
//                     child: Image.asset(
//                       'assets/images/gamelan.png',
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Ornamen Batik Kanan Bawah
//                 Positioned(
//                   bottom: 200,
//                   right: -30,
//                   child: Opacity(
//                     opacity: 0.9,
//                     child: Image.asset(
//                       'assets/images/wayang.png',
//                       width: 140,
//                       height: 140,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Main content - PERBAIKAN: Tambahkan LayoutBuilder
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     return SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minHeight: constraints.maxHeight,
//                         ),
//                         child: IntrinsicHeight(
//                           child: Padding(
//                             padding: const EdgeInsets.all(24.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(height: 20),
//
//                                 // Welcome message
//                                 const Text(
//                                   'Selamat Datang!',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 36,
//                                     fontWeight: FontWeight.bold,
//                                     height: 1.2,
//                                     shadows: [
//                                       Shadow(
//                                         offset: Offset(0, 2),
//                                         blurRadius: 8,
//                                         color: Colors.black54,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 const Text(
//                                   'Siap menerjemahkan aksara Jawa\nhari ini?',
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 16,
//                                     height: 1.5,
//                                     shadows: [
//                                       Shadow(
//                                         offset: Offset(0, 1),
//                                         blurRadius: 4,
//                                         color: Colors.black45,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 60),
//
//                                 // Banners dengan gambar gamelan
//                                 Stack(
//                                   children: [
//                                     Column(
//                                       children: const [
//                                         _GuideBanner(),
//                                         SizedBox(height: 24),
//                                         _HistoryBanner(),
//                                       ],
//                                     ),
//                                     // Gambar Gamelan di tengah (antara dua banner)
//                                     Positioned(
//                                       bottom: -30,
//                                       right: 0,
//                                       child: Opacity(
//                                         opacity: 0.5,
//                                         child: Image.asset(
//                                           'assets/images/gamelan.png',
//                                           width: 180,
//                                           height: 120,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 const Spacer(), // Mendorong konten ke atas jika layar terlalu tinggi
//                                 const SizedBox(height: 100), // Padding bawah untuk bottom navigation
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 // Ornamen dekoratif bawah
//                 Positioned(
//                   bottom: -20,
//                   left: -20,
//                   child: Opacity(
//                     opacity: 0.25,
//                     child: Image.asset(
//                       'assets/images/wayang.png',
//                       width: 200,
//                       height: 120,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(24.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF1E2A4A).withOpacity(0.9),
//               const Color(0xFF0F1729).withOpacity(0.85),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.blue.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue.withOpacity(0.2),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon container dengan gradient
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.blue.withOpacity(0.4),
//                     Colors.blue.withOpacity(0.2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.blue.withOpacity(0.5),
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 44,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Color(0xFF5DADE2),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFF5DADE2),
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HistoryBanner extends StatelessWidget {
//   const _HistoryBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(24.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF2A1E4A).withOpacity(0.9),
//               const Color(0xFF170F29).withOpacity(0.85),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.purple.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purple.withOpacity(0.2),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon container dengan gradient
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.purple.withOpacity(0.4),
//                     Colors.purple.withOpacity(0.2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.purple.withOpacity(0.5),
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.history_edu_rounded,
//                 color: Colors.purple,
//                 size: 44,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sejarah Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Jelajahi asal-usulnya',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: const [
//                       Text(
//                         'Lihat selengkapnya',
//                         style: TextStyle(
//                           color: Color(0xFFBB8FCE),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFFBB8FCE),
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
// import 'javanese_history_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0E27),
//       body: Stack(
//         children: [
//           // Background Image/Wallpaper - Fullscreen tanpa SafeArea
//           Positioned.fill(
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/wallpaper_batik.jpeg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//
//           // Dark overlay untuk membuat text lebih terbaca
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.7),
//                     Colors.black.withOpacity(0.5),
//                     Colors.black.withOpacity(0.8),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Content dengan SafeArea
//           SafeArea(
//             child: Stack(
//               children: [
//                 // Gambar Wayang Kiri Atas
//                 Positioned(
//                   top: -20,
//                   left: -30,
//                   child: Opacity(
//                     opacity: 0.4,
//                     child: Image.asset(
//                       'assets/images/wayang.png',
//                       width: 180,
//                       height: 180,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Gambar Wayang Kanan (Tokoh Utama)
//                 Positioned(
//                   top: 40,
//                   right: 10,
//                   child: Opacity(
//                     opacity: 0.7,
//                     child: Image.asset(
//                       'assets/images/wayang_panggon.png',
//                       width: 160,
//                       height: 200,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Ornamen Batik Kiri
//                 Positioned(
//                   top: 120,
//                   left: -40,
//                   child: Opacity(
//                     opacity: 0.3,
//                     child: Image.asset(
//                       'assets/images/gamelan.png',
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Ornamen Batik Kanan Bawah
//                 Positioned(
//                   bottom: 200,
//                   right: -30,
//                   child: Opacity(
//                     opacity: 0.3,
//                     child: Image.asset(
//                       'assets/images/wayang.png',
//                       width: 140,
//                       height: 140,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Main content
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 20),
//
//                         // Welcome message
//                         const Text(
//                           'Selamat Datang!',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold,
//                             height: 1.2,
//                             shadows: [
//                               Shadow(
//                                 offset: Offset(0, 2),
//                                 blurRadius: 8,
//                                 color: Colors.black54,
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         const Text(
//                           'Siap menerjemahkan aksara Jawa\nhari ini?',
//                           style: TextStyle(
//                             color: Colors.white70,
//                             fontSize: 16,
//                             height: 1.5,
//                             shadows: [
//                               Shadow(
//                                 offset: Offset(0, 1),
//                                 blurRadius: 4,
//                                 color: Colors.black45,
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 60),
//
//                         // Banners dengan gambar gamelan
//                         Stack(
//                           children: [
//                             Column(
//                               children: const [
//                                 _GuideBanner(),
//                                 SizedBox(height: 24),
//                                 _HistoryBanner(),
//                               ],
//                             ),
//                             // Gambar Gamelan di tengah (antara dua banner)
//                             Positioned(
//                               bottom: -30,
//                               right: 0,
//                               child: Opacity(
//                                 opacity: 0.5,
//                                 child: Image.asset(
//                                   'assets/images/gamelan.png',
//                                   width: 180,
//                                   height: 120,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 40),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Ornamen dekoratif bawah
//                 Positioned(
//                   bottom: -20,
//                   left: -20,
//                   child: Opacity(
//                     opacity: 0.25,
//                     child: Image.asset(
//                       'assets/images/wayang.png',
//                       width: 200,
//                       height: 120,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(24.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF1E2A4A).withOpacity(0.9),
//               const Color(0xFF0F1729).withOpacity(0.85),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.blue.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue.withOpacity(0.2),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon container dengan gradient
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.blue.withOpacity(0.4),
//                     Colors.blue.withOpacity(0.2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.blue.withOpacity(0.5),
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 44,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Color(0xFF5DADE2),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFF5DADE2),
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HistoryBanner extends StatelessWidget {
//   const _HistoryBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(24.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF2A1E4A).withOpacity(0.9),
//               const Color(0xFF170F29).withOpacity(0.85),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.purple.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purple.withOpacity(0.2),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon container dengan gradient
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.purple.withOpacity(0.4),
//                     Colors.purple.withOpacity(0.2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.purple.withOpacity(0.5),
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.history_edu_rounded,
//                 color: Colors.purple,
//                 size: 44,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sejarah Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Jelajahi asal-usulnya',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: const [
//                       Text(
//                         'Lihat selengkapnya',
//                         style: TextStyle(
//                           color: Color(0xFFBB8FCE),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFFBB8FCE),
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
// import 'javanese_history_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0E27),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background Image/Wallpaper
//             Positioned.fill(
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/wallpaper_batik.jpeg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//
//             // Dark overlay untuk membuat text lebih terbaca
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.7),
//                       Colors.black.withOpacity(0.5),
//                       Colors.black.withOpacity(0.8),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // Gambar Wayang Kiri Atas
//             Positioned(
//               top: -20,
//               left: -30,
//               child: Opacity(
//                 opacity: 0.4,
//                 child: Image.asset(
//                   'assets/images/wayang.png',
//                   width: 180,
//                   height: 180,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Gambar Wayang Kanan (Tokoh Utama)
//             Positioned(
//               top: 40,
//               right: 10,
//               child: Opacity(
//                 opacity: 0.7,
//                 child: Image.asset(
//                   'assets/images/wayang_panggon.png',
//                   width: 160,
//                   height: 200,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Ornamen Batik Kiri
//             Positioned(
//               top: 120,
//               left: -40,
//               child: Opacity(
//                 opacity: 0.3,
//                 child: Image.asset(
//                   'assets/images/gamelan.png',
//                   width: 150,
//                   height: 150,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Ornamen Batik Kanan Bawah
//             Positioned(
//               bottom: 200,
//               right: -30,
//               child: Opacity(
//                 opacity: 0.3,
//                 child: Image.asset(
//                   'assets/images/wayang.png',
//                   width: 140,
//                   height: 140,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Main content
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//
//                     // Welcome message
//                     const Text(
//                       'Selamat Datang!',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                         height: 1.2,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(0, 2),
//                             blurRadius: 8,
//                             color: Colors.black54,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Siap menerjemahkan aksara Jawa\nhari ini?',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16,
//                         height: 1.5,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(0, 1),
//                             blurRadius: 4,
//                             color: Colors.black45,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 60),
//
//                     // Banners dengan gambar gamelan
//                     Stack(
//                       children: [
//                         Column(
//                           children: const [
//                             _GuideBanner(),
//                             SizedBox(height: 24),
//                             _HistoryBanner(),
//                           ],
//                         ),
//                         // Gambar Gamelan di tengah (antara dua banner)
//                         Positioned(
//                           bottom: -30,
//                           right: 0,
//                           child: Opacity(
//                             opacity: 0.5,
//                             child: Image.asset(
//                               'assets/images/gamelan.png',
//                               width: 180,
//                               height: 120,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Ornamen dekoratif bawah
//             Positioned(
//               bottom: -20,
//               left: -20,
//               child: Opacity(
//                 opacity: 0.25,
//                 child: Image.asset(
//                   'assets/images/wayang.png',
//                   width: 200,
//                   height: 120,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(24.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF1E2A4A).withOpacity(0.9),
//               const Color(0xFF0F1729).withOpacity(0.85),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.blue.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue.withOpacity(0.2),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon container dengan gradient
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.blue.withOpacity(0.4),
//                     Colors.blue.withOpacity(0.2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.blue.withOpacity(0.5),
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 44,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Color(0xFF5DADE2),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFF5DADE2),
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HistoryBanner extends StatelessWidget {
//   const _HistoryBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(24.0),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color(0xFF2A1E4A).withOpacity(0.9),
//               const Color(0xFF170F29).withOpacity(0.85),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           border: Border.all(
//             color: Colors.purple.withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purple.withOpacity(0.2),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.4),
//               blurRadius: 15,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon container dengan gradient
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.purple.withOpacity(0.4),
//                     Colors.purple.withOpacity(0.2),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.purple.withOpacity(0.5),
//                   width: 1,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.history_edu_rounded,
//                 color: Colors.purple,
//                 size: 44,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sejarah Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     'Jelajahi asal-usulnya',
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: const [
//                       Text(
//                         'Lihat selengkapnya',
//                         style: TextStyle(
//                           color: Color(0xFFBB8FCE),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(width: 6),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Color(0xFFBB8FCE),
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }














// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
// import 'javanese_history_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   double _wallpaperOpacity = 0.7; // Opacity wallpaper (0.0 - 1.0)
//   double _overlayOpacity = 0.2; // Opacity overlay gelap (0.0 - 1.0)
//   bool _showControls = false; // Toggle untuk menampilkan kontrol
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background Image/Wallpaper
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: const AssetImage('assets/images/wallpaper_batik.jpeg'),
//                     fit: BoxFit.cover,
//                     opacity: _wallpaperOpacity, // Opacity bisa diatur
//                   ),
//                 ),
//               ),
//             ),
//
//             // Overlay gradient (opsional, bisa diatur opacity-nya)
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(_overlayOpacity),
//                       Colors.black.withOpacity(_overlayOpacity * 0.5),
//                       Colors.black.withOpacity(_overlayOpacity),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // Visual effect: decorative circles
//             Positioned(
//               top: -50,
//               left: -50,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               right: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.deepPurple.withOpacity(0.1),
//                 ),
//               ),
//             ),
//
//             // Main content
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Welcome message
//                   const Text(
//                     'Selamat Datang!',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       shadows: [
//                         Shadow(
//                           offset: Offset(0, 2),
//                           blurRadius: 4,
//                           color: Colors.black45,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Siap menerjemahkan aksara Jawa hari ini?',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                       shadows: [
//                         Shadow(
//                           offset: Offset(0, 1),
//                           blurRadius: 3,
//                           color: Colors.black45,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//
//                   // === BAGIAN GAMBAR BARU ===
//                   // Panggil method untuk menampilkan gambar di sini.
//                   _buildImageShowcase(),
//
//                   // Spacer akan mendorong widget di bawahnya ke bagian bawah layar.
//                   const Spacer(),
//
//                   // Banners
//                   const _GuideBanner(),
//                   const SizedBox(height: 20),
//                   const _HistoryBanner(),
//                 ],
//               ),
//             ),
//
//             // Floating button untuk mengatur opacity
//             Positioned(
//               top: 16,
//               right: 16,
//               child: FloatingActionButton(
//                 mini: true,
//                 backgroundColor: Colors.white.withOpacity(0.2),
//                 onPressed: () {
//                   setState(() {
//                     _showControls = !_showControls;
//                   });
//                 },
//                 child: Icon(
//                   _showControls ? Icons.close : Icons.tune,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//
//             // Panel kontrol opacity
//             if (_showControls)
//               Positioned(
//                 top: 70,
//                 right: 16,
//                 child: Container(
//                   width: 280,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.85),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'Pengaturan Wallpaper',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Slider untuk opacity wallpaper
//                       const Text(
//                         'Kecerahan Wallpaper',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.brightness_low,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                           Expanded(
//                             child: Slider(
//                               value: _wallpaperOpacity,
//                               min: 0.0,
//                               max: 1.0,
//                               activeColor: Colors.blue,
//                               inactiveColor: Colors.white24,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _wallpaperOpacity = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const Icon(
//                             Icons.brightness_high,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '${(_wallpaperOpacity * 100).toInt()}%',
//                         style: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 12,
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Slider untuk overlay gelap
//                       const Text(
//                         'Overlay Gelap',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.layers_clear,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                           Expanded(
//                             child: Slider(
//                               value: _overlayOpacity,
//                               min: 0.0,
//                               max: 0.8,
//                               activeColor: Colors.purple,
//                               inactiveColor: Colors.white24,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _overlayOpacity = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const Icon(
//                             Icons.layers,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '${(_overlayOpacity * 100).toInt()}%',
//                         style: const TextStyle(
//                           color: Colors.purple,
//                           fontSize: 12,
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Tombol reset
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             setState(() {
//                               _wallpaperOpacity = 0.7;
//                               _overlayOpacity = 0.2;
//                             });
//                           },
//                           icon: const Icon(Icons.refresh, size: 16),
//                           label: const Text('Reset Default'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white.withOpacity(0.1),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- PANDUAN KUSTOMISASI TAMPILAN GAMBAR ---
//   //
//   // Widget ini bertanggung jawab untuk mengatur tata letak gambar.
//   // Anda bisa mengubah orientasi, jumlah, dan susunan gambar di sini.
//   //
//   // TIPS:
//   // 1. Mengubah Orientasi:
//   //    - Untuk tata letak HORIZONTAL, gunakan `Row`.
//   //    - Untuk tata letak VERTIKAL, ganti `Row` menjadi `Column`.
//   //
//   // 2. Menambah/Mengurangi Gambar:
//   //    - Cukup tambahkan atau hapus widget `_buildImageCard()` di dalam `Row` atau `Column`.
//   //    - Pastikan path gambar di `assets/images/` sudah benar.
//   //
//   // 3. Membuat Grid (Contoh: 2x2):
//   //    - Gunakan `Column` yang berisi beberapa `Row`. Lihat contoh di bawah.
//   //
//   Widget _buildImageShowcase() {
//     return Column(
//       children: [
//         // Baris pertama gambar
//         Row(
//           children: [
//             // Gambar 1
//             _buildImageCard('assets/images/wayang_panggon.png'),
//             const SizedBox(width: 16), // Jarak antar gambar
//             // Gambar 2
//             _buildImageCard('assets/images/aksara_2.png'),
//           ],
//         ),
//         const SizedBox(height: 16), // Jarak antar baris
//         // Baris kedua gambar
//         Row(
//           children: [
//             // Gambar 3
//             _buildImageCard('assets/images/aksara_3.png'),
//             const SizedBox(width: 16), // Jarak antar gambar
//             // Gambar 4
//             _buildImageCard('assets/images/aksara_4.png'),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // --- PANDUAN KUSTOMISASI SATU GAMBAR ---
//   //
//   // Widget ini untuk mengatur tampilan SATU buah gambar.
//   // Anda bisa mengubah tinggi, lengkungan sudut, bayangan, dll.
//   //
//   // TIPS:
//   // 1. `height`: Ubah nilai ini untuk mengatur tinggi gambar.
//   // 2. `borderRadius`: Ubah nilai `BorderRadius.circular()` untuk membuat sudut lebih tumpul atau tajam.
//   // 3. `fit`: Ganti `BoxFit.cover` dengan `BoxFit.contain`, `BoxFit.fill`, dll., untuk mengubah cara gambar ditampilkan.
//   // 4. `Expanded`: Widget ini membuat setiap gambar mengambil ruang yang sama secara horizontal. Hapus jika ingin ukuran gambar berbeda.
//   //
//   Widget _buildImageCard(String imagePath) {
//     return Expanded(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12.0),
//         child: Container(
//           height: 120, // Atur tinggi gambar di sini
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.3),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover, // Atur cara gambar mengisi container
//               // Jika gambar gagal dimuat, tampilkan icon error
//               onError: (exception, stackTrace) {
//                 // Anda bisa membiarkannya kosong atau menampilkan widget lain
//               },
//             ),
//           ),
//           // Anda bisa menambahkan teks atau ikon di atas gambar di sini
//           // child: Align(
//           //   alignment: Alignment.bottomLeft,
//           //   child: Padding(
//           //     padding: const EdgeInsets.all(8.0),
//           //     child: Text('Contoh Teks', style: TextStyle(color: Colors.white)),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A).withOpacity(0.85),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.blue.withOpacity(0.5)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.blue,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HistoryBanner extends StatelessWidget {
//   const _HistoryBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A).withOpacity(0.85),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.purple.withOpacity(0.5)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.purple.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.history_edu_rounded,
//                 color: Colors.purple,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sejarah Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Jelajahi asal-usulnya',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Lihat selengkapnya',
//                         style: TextStyle(
//                           color: Colors.purple,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.purple,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











//USSEEE  TTTHHIIISSSSS
// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
// import 'javanese_history_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   double _wallpaperOpacity = 0.7; // Opacity wallpaper (0.0 - 1.0)
//   double _overlayOpacity = 0.2; // Opacity overlay gelap (0.0 - 1.0)
//   bool _showControls = false; // Toggle untuk menampilkan kontrol
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background Image/Wallpaper
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: const AssetImage('assets/images/wallpaper_batik.jpeg'),
//                     fit: BoxFit.cover,
//                     opacity: _wallpaperOpacity, // Opacity bisa diatur
//                   ),
//                 ),
//               ),
//             ),
//
//             // Overlay gradient (opsional, bisa diatur opacity-nya)
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(_overlayOpacity),
//                       Colors.black.withOpacity(_overlayOpacity * 0.5),
//                       Colors.black.withOpacity(_overlayOpacity),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // Visual effect: decorative circles
//             Positioned(
//               top: -50,
//               left: -50,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               right: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.deepPurple.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: -20,
//               left: -30,
//               child: Opacity(
//                 opacity: 0.9,
//                 child: Image.asset(
//                   'assets/images/wayang.png',
//                   width: 180,
//                   height: 180,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Main content
//             ListView(
//               padding: const EdgeInsets.all(24.0),
//               children: const [
//                 // Welcome message
//                 Text(
//                   'Selamat Datang!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       Shadow(
//                         offset: Offset(0, 2),
//                         blurRadius: 4,
//                         color: Colors.black45,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Siap menerjemahkan aksara Jawa hari ini?',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                     shadows: [
//                       Shadow(
//                         offset: Offset(0, 1),
//                         blurRadius: 3,
//                         color: Colors.black45,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 // Banners
//                 _GuideBanner(),
//                 SizedBox(height: 20),
//                 _HistoryBanner(),
//               ],
//             ),
//
//             // Floating button untuk mengatur opacity
//             Positioned(
//               top: 16,
//               right: 16,
//               child: FloatingActionButton(
//                 mini: true,
//                 backgroundColor: Colors.white.withOpacity(0.2),
//                 onPressed: () {
//                   setState(() {
//                     _showControls = !_showControls;
//                   });
//                 },
//                 child: Icon(
//                   _showControls ? Icons.close : Icons.tune,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//
//             // Panel kontrol opacity
//             if (_showControls)
//               Positioned(
//                 top: 70,
//                 right: 16,
//                 child: Container(
//                   width: 280,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.85),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'Pengaturan Wallpaper',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // Slider untuk opacity wallpaper
//                       const Text(
//                         'Kecerahan Wallpaper',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.brightness_low,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                           Expanded(
//                             child: Slider(
//                               value: _wallpaperOpacity,
//                               min: 0.0,
//                               max: 1.0,
//                               activeColor: Colors.blue,
//                               inactiveColor: Colors.white24,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _wallpaperOpacity = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const Icon(
//                             Icons.brightness_high,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '${(_wallpaperOpacity * 100).toInt()}%',
//                         style: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 12,
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Slider untuk overlay gelap
//                       const Text(
//                         'Overlay Gelap',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.layers_clear,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                           Expanded(
//                             child: Slider(
//                               value: _overlayOpacity,
//                               min: 0.0,
//                               max: 0.8,
//                               activeColor: Colors.purple,
//                               inactiveColor: Colors.white24,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _overlayOpacity = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const Icon(
//                             Icons.layers,
//                             color: Colors.white54,
//                             size: 20,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '${(_overlayOpacity * 100).toInt()}%',
//                         style: const TextStyle(
//                           color: Colors.purple,
//                           fontSize: 12,
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       // Tombol reset
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             setState(() {
//                               _wallpaperOpacity = 0.7;
//                               _overlayOpacity = 0.2;
//                             });
//                           },
//                           icon: const Icon(Icons.refresh, size: 16),
//                           label: const Text('Reset Default'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white.withOpacity(0.1),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A).withOpacity(0.85),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.blue.withOpacity(0.5)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.blue,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HistoryBanner extends StatelessWidget {
//   const _HistoryBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A).withOpacity(0.85),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.purple.withOpacity(0.5)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.purple.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.history_edu_rounded,
//                 color: Colors.purple,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sejarah Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Jelajahi asal-usulnya',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Lihat selengkapnya',
//                         style: TextStyle(
//                           color: Colors.purple,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.purple,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Visual effect: decorative circles
//             Positioned(
//               top: -50,
//               left: -50,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               right: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.deepPurple.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             // Main content
//             ListView(
//               padding: const EdgeInsets.all(24.0),
//               children: const [
//                 // Welcome message
//                 Text(
//                   'Selamat Datang!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Siap menerjemahkan aksara Jawa hari ini?',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 // Banners
//                 _GuideBanner(),
//                 SizedBox(height: 20),
//                 _HistoryBanner(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to the guide page
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.blue.withOpacity(0.5)),
//         ),
//         child: Row(
//           children: [
//             // Image/Icon on the left
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             // Text content on the right
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.blue,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HistoryBanner extends StatelessWidget {
//   const _HistoryBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // TODO: Navigate to the history page
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.purple.withOpacity(0.5)),
//         ),
//         child: Row(
//           children: [
//             // Image/Icon on the left
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.purple.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.history_edu_rounded,
//                 color: Colors.purple,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             // Text content on the right
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Sejarah Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Jelajahi asal-usulnya',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Lihat selengkapnya',
//                         style: TextStyle(
//                           color: Colors.purple,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.purple,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'javanese_guide_page.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Visual effect: decorative circles
//             Positioned(
//               top: -50,
//               left: -50,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: -100,
//               right: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.deepPurple.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             // Main content
//             ListView(
//               padding: const EdgeInsets.all(24.0),
//               children: const [
//                 // Welcome message
//                 Text(
//                   'Selamat Datang!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Siap menerjemahkan aksara Jawa hari ini?',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 // Banner
//                 _GuideBanner(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _GuideBanner extends StatelessWidget {
//   const _GuideBanner();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to the guide page
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1F223A),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.blue.withOpacity(0.5)),
//         ),
//         child: Row(
//           children: [
//             // Image/Icon on the left
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(
//                 Icons.menu_book_rounded,
//                 color: Colors.blue,
//                 size: 40,
//               ),
//             ),
//             const SizedBox(width: 20),
//             // Text content on the right
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Panduan Lengkap',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     'Aturan Aksara Jawa',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: const [
//                       Text(
//                         'Mulai belajar sekarang!',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.blue,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Home Page',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Use SafeArea to prevent the UI from overlapping with the status bar.
//     return const SafeArea(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // The main card containing the translator UI.
//             Expanded(
//               child: _MainTranslatorCard(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _MainTranslatorCard extends StatelessWidget {
//   const _MainTranslatorCard();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F243F), // Card background color
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Column(
//         children: [
//           const _TopBar(),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: _TranslationBox(
//                       language: 'Indonesia',
//                       text:
//                       'Serangan terhadap warga Asia New York baru-baru ini menyebabkan empat kematian...',
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: _TranslationBox(
//                       language: 'English',
//                       text:
//                       'Attacks against Asian New Yorkers have recently led to four deaths...',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const _LanguageSelector(),
//           const SizedBox(height: 20), // Bottom padding inside the card
//         ],
//       ),
//     );
//   }
// }
//
// class _TopBar extends StatelessWidget {
//   const _TopBar();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Translator',
//             style: TextStyle(
//                 color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings_outlined, color: Colors.white),
//             onPressed: () {
//               // Placeholder for settings action
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TranslationBox extends StatelessWidget {
//   final String language;
//   final String text;
//
//   const _TranslationBox({required this.language, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF262D4D), // Inner box color
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
//                   color: Colors.white, fontSize: 16, height: 1.5),
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                   icon: Icon(Icons.copy_outlined,
//                       color: Colors.grey[400], size: 22),
//                   onPressed: () {}),
//               const Spacer(),
//               IconButton(
//                   icon: Icon(Icons.volume_up_outlined,
//                       color: Colors.grey[400], size: 22),
//                   onPressed: () {}),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _LanguageSelector extends StatelessWidget {
//   const _LanguageSelector();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('Indonesia',
//               style: TextStyle(color: Colors.white, fontSize: 16)),
//           InkWell(
//             onTap: () {}, // Placeholder for swap language action
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF3D52F8),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.swap_horiz, color: Colors.white, size: 24),
//             ),
//           ),
//           const Text('English',
//               style: TextStyle(color: Colors.white, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     children: const [
//                       Icon(Icons.wb_sunny, color: Colors.blue, size: 16),
//                       SizedBox(width: 4),
//                       Text(''),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.menu, color: Colors.white),
//               ],
//             ),
//             const SizedBox(height: 24),
//             Expanded(
//               child: ListView(
//                 children: [
//                   buildTranslationCard(
//                     'Indonesia',
//                     'Serangan terhadap warga Asia New York baru-baru ini menyebabkan empat kematian. Yao Pan Ma, seorang imigran Cina',
//                   ),
//                   const SizedBox(height: 8),
//                   buildTranslationCard(
//                     'English',
//                     'Attacks against Asian New Yorkers have recently led to four deaths. Yao Pan Ma, a Chinese immigrant,',
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             buildLanguageSelector(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTranslationCard(String language, String text) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F223A),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             language,
//             style: const TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             text,
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: const [
//               Icon(Icons.copy, color: Colors.grey, size: 20),
//               SizedBox(width: 16),
//               Icon(Icons.share, color: Colors.grey, size: 20),
//               SizedBox(width: 16),
//               Icon(Icons.volume_up, color: Colors.grey, size: 20),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildLanguageSelector() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F223A),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text('Indonesia', style: TextStyle(color: Colors.white)),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.swap_horiz, color: Colors.white),
//           ),
//           const Text('English', style: TextStyle(color: Colors.white)),
//         ],
//       ),
//     );
//   }
// }
