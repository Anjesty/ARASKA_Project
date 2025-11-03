import 'package:flutter/material.dart';
import 'javanese_guide_page.dart';
import 'javanese_history_page.dart'; // Import halaman sejarah yang baru

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Stack(
          children: [
            // Visual effect: decorative circles
            Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withOpacity(0.1),
                ),
              ),
            ),
            // Main content
            ListView(
              padding: const EdgeInsets.all(24.0),
              children: const [
                // Welcome message
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Siap menerjemahkan aksara Jawa hari ini?',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),
                // Banners
                _GuideBanner(),
                SizedBox(height: 20),
                _HistoryBanner(),
              ],
            ),
          ],
        ),
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
        // Navigate to the guide page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JavaneseGuidePage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1F223A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            // Image/Icon on the left
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
                size: 40,
              ),
            ),
            const SizedBox(width: 20),
            // Text content on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Panduan Lengkap',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Aturan Aksara Jawa',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text(
                        'Mulai belajar sekarang!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
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
        // Navigate to the history page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JavaneseHistoryPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF1F223A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            // Image/Icon on the left
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.history_edu_rounded,
                color: Colors.purple,
                size: 40,
              ),
            ),
            const SizedBox(width: 20),
            // Text content on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sejarah Aksara Jawa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Jelajahi asal-usulnya',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text(
                        'Lihat selengkapnya',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.purple,
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
