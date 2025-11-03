import 'package:flutter/material.dart';

class JavaneseHistoryPage extends StatelessWidget {
  const JavaneseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Sejarah Aksara Jawa'),
        backgroundColor: const Color(0xFF1F223A),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildParagraph(
              'Selamat datang di fitur Sejarah Aksara Jawa! Tahukah Anda? Aksara yang Anda pelajari dan gunakan di aplikasi ini memiliki dua sisi cerita asal-usul yang sangat menarik.'),
          _buildParagraph(
              'Ada kisah legendaris yang hidup di tengah masyarakat, dan ada pula jejak sejarah yang diteliti oleh para ilmuwan. Mari kita telusuri keduanya.'),
          const SizedBox(height: 20),
          _buildSectionTitle('1. Kisah Legendaris Aji Saka'),
          _buildParagraph(
              'Ini adalah cerita yang paling sering Anda dengar dan menjadi bagian dari budaya Jawa. Kisah ini berpusat pada seorang pahlawan bijaksana bernama Aji Saka.'),
          _buildBulletPoint('Dua Abdi Setia',
              'Aji Saka dikisahkan memiliki dua abdi yang sangat setia, bernama Dora dan Sembodo.'),
          _buildBulletPoint('Amanat Pusaka',
              'Suatu ketika, Aji Saka harus pergi dan meninggalkan pusakanya (sering dikisahkan sebagai keris) kepada Sembodo. Pesannya sangat tegas: "Jangan serahkan pusaka ini kepada siapa pun, kecuali aku sendiri yang mengambilnya".'),
          _buildBulletPoint('Tragedi Kesetiaan',
              'Beberapa waktu kemudian, Aji Saka mengutus Dora untuk mengambil pusaka tersebut. Di sinilah terjadi tragedi. Sembodo menolak memberikannya karena ia memegang teguh sumpah dan amanat Aji Saka. Di sisi lain, Dora juga bersikeras menjalankan perintah terbaru dari tuannya.'),
          _buildBulletPoint('Lahirnya 20 Aksara',
              'Karena keduanya merasa menjalankan tugas dan sama-sama setia, mereka bertarung. Karena keduanya sama-sama sakti (padha jayanya), pertarungan itu berakhir dengan tewasnya mereka berdua (maga bathanga). Aji Saka, yang menemukan kedua abdinya tewas, sangat bersedih. Untuk mengenang kesetiaan dan tragedi tersebut, ia menciptakan 20 aksara yang merangkum keseluruhan cerita itu. Inilah yang kita kenal sebagai urutan Hanacaraka:'),
          _buildHanacarakaList(),
          const SizedBox(height: 20),
          _buildSectionTitle('2. Jejak Ilmiah (Paleografi)'),
          _buildParagraph(
              'Selain legenda, para ilmuwan memiliki penjelasan ilmiah melalui studi Paleografi, yaitu ilmu yang mempelajari bentuk tulisan kuno. Menurut pendekatan ilmiah, Aksara Jawa tidak diciptakan secara tiba-tiba. Aksara ini adalah hasil evolusi panjang selama ribuan tahun.'),
          _buildBulletPoint('Akar dari India',
              'Perjalanan aksara ini dimulai dari Aksara Brahmi di India. Aksara ini kemudian berkembang menjadi Aksara Pallawa di India Selatan.'),
          _buildBulletPoint('Masuk ke Nusantara',
              'Aksara Pallawa inilah yang pertama kali masuk ke Nusantara, dibawa melalui jalur perdagangan dan penyebaran agama. Bukti tertuanya adalah prasasti Yupa di Kalimantan Timur dan prasasti-prasasti dari Kerajaan Tarumanegara.'),
          _buildBulletPoint('Menjadi Aksara Kawi (Jawa Kuno)',
              'Di Jawa, Aksara Pallawa perlahan beradaptasi dengan bahasa lokal dan berkembang menjadi Aksara Kawi. Aksara ini digunakan secara luas pada periode kerajaan Hindu-Buddha (sekitar abad 8-15 M). Buktinya ada di banyak prasasti, seperti Prasasti Dinoyo dan prasasti-prasasti dari era Raja Airlangga.'),
          _buildBulletPoint('Menjadi Aksara Jawa Baru (Hanacaraka)',
              'Aksara Kawi terus berevolusi. Melalui era Majapahit (sekitar 1250-1450 M), bentuknya terus berubah hingga akhirnya menjadi Aksara Jawa Baru (Hanacaraka) yang kita gunakan saat ini, yang diperkirakan mulai terbentuk sejak abad ke-15.'),
          const SizedBox(height: 20),
          _buildSectionTitle('Studi Kasus: Evolusi Aksara Kwadrat'),
          _buildParagraph(
              'Penelitian ilmiah bisa sangat detail. Contohnya, penelitian oleh Titi Surti Nastiti (seorang ahli epigrafi) meneliti gaya "Aksara Kwadrat" (gaya aksara yang bentuknya kotak-kotak dan dekoratif).'),
          _buildBulletPoint(null,
              'Orang sering mengira aksara gaya ini hanya ada di zaman Kerajaan Kadiri (abad ke-12). Namun, penelitian paleografi membuktikan aksara ini jauh lebih tua.'),
          _buildBulletPoint(null,
              'Bentuk paling awalnya ditemukan di Petirtaan Jalatunda, yang berasal dari tahun 977 M. Ini adalah era sebelum Kadiri, yaitu masa Raja Makuțawangśawarddhana (ayah dari Dharmawangsa Tguh).'),
          _buildBulletPoint(null,
              'Ini membuktikan bahwa Aksara Jawa terus berkembang secara perlahan dan berkesinambungan dari satu era ke era berikutnya.'),
          const SizedBox(height: 20),
          _buildSectionTitle('Kesimpulan'),
          _buildParagraph(
              'Legenda Aji Saka memberi kita makna filosofis yang mendalam tentang kesetiaan dan takdir.'),
          _buildParagraph(
              'Di sisi lain, jejak ilmiah memberi kita bukti sejarah yang nyata, menunjukkan bagaimana aksara ini berevolusi dan beradaptasi seiring perjalanan panjang peradaban di Nusantara.'),
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

  Widget _buildBulletPoint(String? title, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
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
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                  fontFamily: 'Roboto', // Ensure consistent font
                ),
                children: [
                  if (title != null)
                    TextSpan(
                      text: '$title: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  TextSpan(text: content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHanacarakaList() {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ha Na Ca Ra Ka (Ada utusan)',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 4),
          Text('Da Ta Sa Wa La (Saling bertengkar)',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 4),
          Text('Pa Dha Ja Ya Nya (Sama-sama saktinya)',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 4),
          Text('Ma Ga Ba Tha Nga (Keduanya menjadi mayat)',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
//
// class JavaneseHistoryPage extends StatelessWidget {
//   const JavaneseHistoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       appBar: AppBar(
//         title: const Text('Sejarah Aksara Jawa'),
//         backgroundColor: const Color(0xFF1F223A),
//         elevation: 0,
//       ),
//       body: const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24.0),
//           child: Text(
//             'Halaman ini akan berisi sejarah lengkap Aksara Jawa, dari asal-usulnya hingga era modern. Konten akan ditambahkan segera.',
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
