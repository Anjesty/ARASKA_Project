import 'package:flutter/material.dart';

class JavaneseGuidePage extends StatelessWidget {
  const JavaneseGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Panduan Aksara Jawa'),
        backgroundColor: const Color(0xFF1F223A),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/images/header art.jpeg', // Changed from Image.network
                height: 200,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.grey, size: 50),
                  );
                },
              ),
            ),
          ),
          _buildSectionTitle('Karakter Dasar dalam Sistem Tulisan Jawa'),
          _buildParagraph(
              'Sistem penulisan Jawa memiliki dua puluh karakter utama yang populer disebut hanacaraka. Karakter-karakter tersebut dikelompokkan ke dalam empat susunan baris:'),
          _buildBulletPoint('ꦲ ꦤ ꦕ ꦫ ꦏ ha na ca ra ka'),
          _buildBulletPoint('ꦢ ꦠ ꦱ ꦮ ꦭ da ta sa wa la'),
          _buildBulletPoint('ꦥ ꦝ ꦗ ꦪ ꦚ pa dha ja ya nya'),
          _buildBulletPoint('ꦩ ꦒ ꦧ ꦛ ꦔ ma ga ba tha nga'),
          _buildImageSection(
            'assets/images/hanacaraka.jpg',
            height: 250,
            fit: BoxFit.cover,
          ),
          _buildParagraph(
              'Masing-masing karakter ini membawa nilai filosofis tersendiri. Lima karakter awal, misalnya, dapat dimaknai sebagai representasi: \'Ha\' melambangkan Sang Pencipta, \'Na\' merepresentasikan manusia, \'Ca\' simbol dari pencerahan, \'Ra\' menggambarkan emosi, dan \'Ka\' mewakili konsep tindakan dan akibatnya.'),
          const SizedBox(height: 20),
          _buildSectionTitle('Penanda Vokal dalam Tulisan Jawa'),
          _buildParagraph(
              'Penanda vokal merupakan simbol tambahan yang mengubah pengucapan vokal dari karakter utama. Beberapa penanda vokal yang penting meliputi:'),
          _buildImageSection(
            'assets/images/sandhangan.png',
            height: 310,
            fit: BoxFit.contain,
          ),
          _buildBulletPoint(
              'Wulu: Membuat bunyi vokal berubah ke "i". Misalnya, karakter "ka" (ꦏ) yang diberi wulu berubah menjadi "ki" (ꦏꦶ).'),
          _buildBulletPoint(
              'Suku: Membuat bunyi vokal berubah ke "u". Misalnya, karakter "pa" (ꦥ) yang diberi suku berubah menjadi "pu" (ꦥꦸ).'),
          _buildBulletPoint(
              'Pepet: Membuat bunyi vokal berubah ke "e" (bunyi seperti dalam "ember"). Misalnya, karakter "da" (ꦢ) yang diberi pepet berubah menjadi "de" (ꦢꦼ).'),
          _buildBulletPoint(
              'Taling: Membuat bunyi vokal berubah ke "é" (bunyi seperti dalam "séga"). Misalnya, karakter "ra" (ꦫ) yang diberi taling berubah menjadi "ré" (ꦫꦺ).'),
          _buildBulletPoint(
              'Taling Tarung: Membuat bunyi vokal berubah ke "o". Misalnya, karakter "ta" (ꦠ) yang diberi taling tarung berubah menjadi "to" (ꦠꦺꦴ).'),
          const SizedBox(height: 20),
          _buildSectionTitle('Bentuk Konsonan Penutup'),
          _buildParagraph(
              'Bentuk konsonan penutup adalah variasi dari karakter dasar yang digunakan untuk menghilangkan bunyi vokal bawaan dari karakter sebelumnya. Bentuk ini ditempatkan di bagian bawah karakter dasar untuk menulis silabel tertutup. Contoh implementasinya:'),
          _buildImageSection(
            'assets/images/pasangan.png',
            height: 350,
            fit: BoxFit.contain,
          ),
          _buildBulletPoint(
              'Karakter "ma" (ꦩ) yang ditambahkan bentuk penutup "ba" (꧀ꦧ) menghasilkan "mba" (ꦩ꧀ꦧ).'),
          _buildBulletPoint(
              'Karakter "ka" (ꦏ) yang ditambahkan bentuk penutup "ka" (꧀ꦏ) menghasilkan "kka" (ꦏ꧀ꦏ).'),
          const SizedBox(height: 20),
          _buildSectionTitle('Karakter Khusus: Murda dan Rekan'),
          _buildParagraph(
              'Dalam sistem tulisan Jawa terdapat dua kategori karakter istimewa:'),
          _buildBulletPoint(
              'Karakter Murda: Memiliki fungsi serupa dengan huruf besar, dipakai untuk menuliskan karakter pembuka pada identitas seseorang, lokasi geografis, atau istilah yang memerlukan penghormatan khusus. Ada delapan karakter yang memiliki varian Murda.'),
          _buildImageSection(
            'assets/images/murda.png',
            height: 250,
            fit: BoxFit.contain,
          ),
          _buildBulletPoint(
              'Karakter Rekan: Merupakan karakter-karakter untuk menuliskan bunyi-bunyi yang berasal dari bahasa luar (seperti bahasa Arab) yang tidak terdapat dalam bunyi asli bahasa Jawa.'),
          _buildImageSection(
            'assets/images/rekan.png',
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Karakter Vokal Mandiri'),
          _buildParagraph(
              'Karakter vokal mandiri adalah simbol vokal yang dapat berdiri sendiri dalam sistem tulisan Jawa, mencakup lima bentuk untuk bunyi a, i, u, é, dan o. Tidak seperti penanda vokal, karakter ini tidak bergantung pada karakter lain dan umumnya digunakan untuk menuliskan silabel vokal di permulaan kata.'),
          const SizedBox(height: 20),
          _buildImageSection(
            'assets/images/vokal.png',
            height: 50,
            fit: BoxFit.contain,
          ),
          _buildSectionTitle('Sistem Angka dan Pungtuasi Jawa'),
          _buildParagraph(
              'Sistem angka dalam tulisan Jawa memiliki bentuk simbolnya sendiri yang khas. Sebagai ilustrasi, angka tiga direpresentasikan dengan "꧓", angka tujuh dengan "꧗", dan angka dua puluh dengan "꧒꧐".'),
          _buildImageSection(
            'assets/images/wilangan.png',
            height: 250,
            fit: BoxFit.contain,
          ),
          _buildParagraph(
              'Sistem tulisan Jawa juga memiliki seperangkat simbol pungtuasi tersendiri untuk mengatur jeda dan tekanan dalam teks. Beberapa simbol pungtuasi utama mencakup:'),
          _buildBulletPoint(
              'Pada lingsa (꧈): Memiliki fungsi yang mirip dengan koma (,).'),
          _buildBulletPoint(
              'Pada lungsi (꧉): Memiliki fungsi yang mirip dengan titik (.).'),
          _buildBulletPoint(
              'Pada pangkat (꧁ ꧂): Memiliki fungsi yang mirip dengan tanda kutip (" ").'),
          _buildImageSection(
            'assets/images/pada1.png',
            height: 450,
            fit: BoxFit.contain,
          ),
          _buildImageSection(
            'assets/images/pada2.png',
            height: 450,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Tambahkan method ini di dalam class JavaneseGuidePage
  Widget _buildImageSection(String imagePath, {
    double height = 150,
    double borderRadius = 12.0,
    BoxFit fit = BoxFit.contain,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16.0),
  }) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Image.asset(
            imagePath,
            height: height,
            width: double.infinity,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 50,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
//
// class JavaneseGuidePage extends StatelessWidget {
//   const JavaneseGuidePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       appBar: AppBar(
//         title: const Text('Panduan Aksara Jawa'),
//         backgroundColor: const Color(0xFF1F223A),
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(24.0),
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 24.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16.0),
//               child: Image.network(
//                 'https://images.unsplash.com/photo-1589241063783-5892a15f0a5d?auto=format&fit=crop&w=1470',
//                 height: 200,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (context, child, loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Container(
//                     height: 200,
//                     color: Colors.black.withOpacity(0.2),
//                     child: const Center(child: CircularProgressIndicator()),
//                   );
//                 },
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                     child: const Icon(Icons.image_not_supported,
//                         color: Colors.grey, size: 50),
//                   );
//                 },
//               ),
//             ),
//           ),
//           _buildSectionTitle('Karakter Dasar dalam Sistem Tulisan Jawa'),
//           _buildParagraph(
//               'Sistem penulisan Jawa memiliki dua puluh karakter utama yang populer disebut hanacaraka. Karakter-karakter tersebut dikelompokkan ke dalam empat susunan baris:'),
//           _buildBulletPoint('ꦲ ꦤ ꦕ ꦫ ꦏ ha na ca ra ka'),
//           _buildBulletPoint('ꦢ ꦠ ꦱ ꦮ ꦭ da ta sa wa la'),
//           _buildBulletPoint('ꦥ ꦝ ꦗ ꦪ ꦚ pa dha ja ya nya'),
//           _buildBulletPoint('ꦩ ꦒ ꦧ ꦛ ꦔ ma ga ba tha nga'),
//           _buildParagraph(
//               'Masing-masing karakter ini membawa nilai filosofis tersendiri. Lima karakter awal, misalnya, dapat dimaknai sebagai representasi: \'Ha\' melambangkan Sang Pencipta, \'Na\' merepresentasikan manusia, \'Ca\' simbol dari pencerahan, \'Ra\' menggambarkan emosi, dan \'Ka\' mewakili konsep tindakan dan akibatnya.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Penanda Vokal dalam Tulisan Jawa'),
//           _buildParagraph(
//               'Penanda vokal merupakan simbol tambahan yang mengubah pengucapan vokal dari karakter utama. Beberapa penanda vokal yang penting meliputi:'),
//           _buildBulletPoint(
//               'Wulu: Membuat bunyi vokal berubah ke "i". Misalnya, karakter "ka" (ꦏ) yang diberi wulu berubah menjadi "ki" (ꦏꦶ).'),
//           _buildBulletPoint(
//               'Suku: Membuat bunyi vokal berubah ke "u". Misalnya, karakter "pa" (ꦥ) yang diberi suku berubah menjadi "pu" (ꦥꦸ).'),
//           _buildBulletPoint(
//               'Pepet: Membuat bunyi vokal berubah ke "e" (bunyi seperti dalam "ember"). Misalnya, karakter "da" (ꦢ) yang diberi pepet berubah menjadi "de" (ꦢꦼ).'),
//           _buildBulletPoint(
//               'Taling: Membuat bunyi vokal berubah ke "é" (bunyi seperti dalam "séga"). Misalnya, karakter "ra" (ꦫ) yang diberi taling berubah menjadi "ré" (ꦫꦺ).'),
//           _buildBulletPoint(
//               'Taling Tarung: Membuat bunyi vokal berubah ke "o". Misalnya, karakter "ta" (ꦠ) yang diberi taling tarung berubah menjadi "to" (ꦠꦺꦴ).'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Bentuk Konsonan Penutup'),
//           _buildParagraph(
//               'Bentuk konsonan penutup adalah variasi dari karakter dasar yang digunakan untuk menghilangkan bunyi vokal bawaan dari karakter sebelumnya. Bentuk ini ditempatkan di bagian bawah karakter dasar untuk menulis silabel tertutup. Contoh implementasinya:'),
//           _buildBulletPoint(
//               'Karakter "ma" (ꦩ) yang ditambahkan bentuk penutup "ba" (꧀ꦧ) menghasilkan "mba" (ꦩ꧀ꦧ).'),
//           _buildBulletPoint(
//               'Karakter "ka" (ꦏ) yang ditambahkan bentuk penutup "ka" (꧀ꦏ) menghasilkan "kka" (ꦏ꧀ꦏ).'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Karakter Khusus: Murda dan Rekan'),
//           _buildParagraph(
//               'Dalam sistem tulisan Jawa terdapat dua kategori karakter istimewa:'),
//           _buildBulletPoint(
//               'Karakter Murda: Memiliki fungsi serupa dengan huruf besar, dipakai untuk menuliskan karakter pembuka pada identitas seseorang, lokasi geografis, atau istilah yang memerlukan penghormatan khusus. Ada delapan karakter yang memiliki varian Murda.'),
//           _buildBulletPoint(
//               'Karakter Rekan: Merupakan karakter-karakter untuk menuliskan bunyi-bunyi yang berasal dari bahasa luar (seperti bahasa Arab) yang tidak terdapat dalam bunyi asli bahasa Jawa.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Karakter Vokal Mandiri'),
//           _buildParagraph(
//               'Karakter vokal mandiri adalah simbol vokal yang dapat berdiri sendiri dalam sistem tulisan Jawa, mencakup lima bentuk untuk bunyi a, i, u, é, dan o. Tidak seperti penanda vokal, karakter ini tidak bergantung pada karakter lain dan umumnya digunakan untuk menuliskan silabel vokal di permulaan kata.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Sistem Angka dan Pungtuasi Jawa'),
//           _buildParagraph(
//               'Sistem angka dalam tulisan Jawa memiliki bentuk simbolnya sendiri yang khas. Sebagai ilustrasi, angka tiga direpresentasikan dengan "꧓", angka tujuh dengan "꧗", dan angka dua puluh dengan "꧒꧐".'),
//           _buildParagraph(
//               'Sistem tulisan Jawa juga memiliki seperangkat simbol pungtuasi tersendiri untuk mengatur jeda dan tekanan dalam teks. Beberapa simbol pungtuasi utama mencakup:'),
//           _buildBulletPoint(
//               'Pada lingsa (꧈): Memiliki fungsi yang mirip dengan koma (,).'),
//           _buildBulletPoint(
//               'Pada lungsi (꧉): Memiliki fungsi yang mirip dengan titik (.).'),
//           _buildBulletPoint(
//               'Pada pangkat (꧁ ꧂): Memiliki fungsi yang mirip dengan tanda kutip (" ").'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildParagraph(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(
//         text,
//         textAlign: TextAlign.justify,
//         style: const TextStyle(
//           color: Colors.white70,
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBulletPoint(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             '• ',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//               height: 1.5,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//                 height: 1.5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class JavaneseGuidePage extends StatelessWidget {
//   const JavaneseGuidePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       appBar: AppBar(
//         title: const Text('Panduan Aksara Jawa'),
//         backgroundColor: const Color(0xFF1F223A),
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(24.0),
//         children: [
//           _buildSectionTitle('Karakter Dasar dalam Sistem Tulisan Jawa'),
//           _buildParagraph(
//               'Sistem penulisan Jawa memiliki dua puluh karakter utama yang populer disebut hanacaraka. Karakter-karakter tersebut dikelompokkan ke dalam empat susunan baris:'),
//           _buildBulletPoint('ꦲ ꦤ ꦕ ꦫ ꦏ ha na ca ra ka'),
//           _buildBulletPoint('ꦢ ꦠ ꦱ ꦮ ꦭ da ta sa wa la'),
//           _buildBulletPoint('ꦥ ꦝ ꦗ ꦪ ꦚ pa dha ja ya nya'),
//           _buildBulletPoint('ꦩ ꦒ ꦧ ꦛ ꦔ ma ga ba tha nga'),
//           _buildParagraph(
//               'Masing-masing karakter ini membawa nilai filosofis tersendiri. Lima karakter awal, misalnya, dapat dimaknai sebagai representasi: \'Ha\' melambangkan Sang Pencipta, \'Na\' merepresentasikan manusia, \'Ca\' simbol dari pencerahan, \'Ra\' menggambarkan emosi, dan \'Ka\' mewakili konsep tindakan dan akibatnya.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Penanda Vokal dalam Tulisan Jawa'),
//           _buildParagraph(
//               'Penanda vokal merupakan simbol tambahan yang mengubah pengucapan vokal dari karakter utama. Beberapa penanda vokal yang penting meliputi:'),
//           _buildBulletPoint(
//               'Wulu: Membuat bunyi vokal berubah ke "i". Misalnya, karakter "ka" (ꦏ) yang diberi wulu berubah menjadi "ki" (ꦏꦶ).'),
//           _buildBulletPoint(
//               'Suku: Membuat bunyi vokal berubah ke "u". Misalnya, karakter "pa" (ꦥ) yang diberi suku berubah menjadi "pu" (ꦥꦸ).'),
//           _buildBulletPoint(
//               'Pepet: Membuat bunyi vokal berubah ke "e" (bunyi seperti dalam "ember"). Misalnya, karakter "da" (ꦢ) yang diberi pepet berubah menjadi "de" (ꦢꦼ).'),
//           _buildBulletPoint(
//               'Taling: Membuat bunyi vokal berubah ke "é" (bunyi seperti dalam "séga"). Misalnya, karakter "ra" (ꦫ) yang diberi taling berubah menjadi "ré" (ꦫꦺ).'),
//           _buildBulletPoint(
//               'Taling Tarung: Membuat bunyi vokal berubah ke "o". Misalnya, karakter "ta" (ꦠ) yang diberi taling tarung berubah menjadi "to" (ꦠꦺꦴ).'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Bentuk Konsonan Penutup'),
//           _buildParagraph(
//               'Bentuk konsonan penutup adalah variasi dari karakter dasar yang digunakan untuk menghilangkan bunyi vokal bawaan dari karakter sebelumnya. Bentuk ini ditempatkan di bagian bawah karakter dasar untuk menulis silabel tertutup. Contoh implementasinya:'),
//           _buildBulletPoint(
//               'Karakter "ma" (ꦩ) yang ditambahkan bentuk penutup "ba" (꧀ꦧ) menghasilkan "mba" (ꦩ꧀ꦧ).'),
//           _buildBulletPoint(
//               'Karakter "ka" (ꦏ) yang ditambahkan bentuk penutup "ka" (꧀ꦏ) menghasilkan "kka" (ꦏ꧀ꦏ).'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Karakter Khusus: Murda dan Rekan'),
//           _buildParagraph(
//               'Dalam sistem tulisan Jawa terdapat dua kategori karakter istimewa:'),
//           _buildBulletPoint(
//               'Karakter Murda: Memiliki fungsi serupa dengan huruf besar, dipakai untuk menuliskan karakter pembuka pada identitas seseorang, lokasi geografis, atau istilah yang memerlukan penghormatan khusus. Ada delapan karakter yang memiliki varian Murda.'),
//           _buildBulletPoint(
//               'Karakter Rekan: Merupakan karakter-karakter untuk menuliskan bunyi-bunyi yang berasal dari bahasa luar (seperti bahasa Arab) yang tidak terdapat dalam bunyi asli bahasa Jawa.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Karakter Vokal Mandiri'),
//           _buildParagraph(
//               'Karakter vokal mandiri adalah simbol vokal yang dapat berdiri sendiri dalam sistem tulisan Jawa, mencakup lima bentuk untuk bunyi a, i, u, é, dan o. Tidak seperti penanda vokal, karakter ini tidak bergantung pada karakter lain dan umumnya digunakan untuk menuliskan silabel vokal di permulaan kata.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Sistem Angka dan Pungtuasi Jawa'),
//           _buildParagraph(
//               'Sistem angka dalam tulisan Jawa memiliki bentuk simbolnya sendiri yang khas. Sebagai ilustrasi, angka tiga direpresentasikan dengan "꧓", angka tujuh dengan "꧗", dan angka dua puluh dengan "꧒꧐".'),
//           _buildParagraph(
//               'Sistem tulisan Jawa juga memiliki seperangkat simbol pungtuasi tersendiri untuk mengatur jeda dan tekanan dalam teks. Beberapa simbol pungtuasi utama mencakup:'),
//           _buildBulletPoint(
//               'Pada lingsa (꧈): Memiliki fungsi yang mirip dengan koma (,).'),
//           _buildBulletPoint(
//               'Pada lungsi (꧉): Memiliki fungsi yang mirip dengan titik (.).'),
//           _buildBulletPoint(
//               'Pada pangkat (꧁ ꧂): Memiliki fungsi yang mirip dengan tanda kutip (" ").'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildParagraph(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Text(
//         text,
//         textAlign: TextAlign.justify,
//         style: const TextStyle(
//           color: Colors.white70,
//           fontSize: 16,
//           height: 1.5,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBulletPoint(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             '• ',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//               height: 1.5,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontSize: 16,
//                 height: 1.5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
//
// class JavaneseGuidePage extends StatelessWidget {
//   const JavaneseGuidePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       appBar: AppBar(
//         title: const Text('Panduan Aksara Jawa'),
//         backgroundColor: const Color(0xFF1F223A),
//         elevation: 0,
//       ),
//       body: const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24.0),
//           child: Text(
//             'Halaman ini akan berisi panduan lengkap dan aturan dalam membaca Aksara Jawa. Konten akan ditambahkan segera.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 18,
//               height: 1.5,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
