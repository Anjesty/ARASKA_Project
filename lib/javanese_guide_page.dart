import 'package:flutter/material.dart';

//======================================================================
// HALAMAN 1: Halaman Menu Utama (JavaneseGuidePage)
//======================================================================

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
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. Intro Card
          _buildIntroCard(),
          const SizedBox(height: 16),

          // 2. Kartu Aksara Dhasar (Langsung ke Detail)
          _buildMainSectionCard(
            context,
            title: 'Karakter Dasar (Aksara Dhasar)',
            icon: Icons.font_download_outlined,
            color: const Color(0xFF4CAF50), // Green
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuideDetailPage( // <-- Hapus 'const' di sini
                    title: 'Aksara Dhasar',
                    description: 'Sistem penulisan Jawa memiliki dua puluh karakter utama yang populer disebut hanacaraka. Masing-masing karakter ini membawa nilai filosofis tersendiri. Lima karakter awal, misalnya, dapat dimaknai sebagai representasi: \'Ha\' melambangkan Sang Pencipta, \'Na\' merepresentasikan manusia, \'Ca\' simbol dari pencerahan, \'Ra\' menggambarkan emosi, dan \'Ka\' mewakili konsep tindakan dan akibatnya.',
                    imagePath: 'assets/images/hanacaraka.jpg',
                    color: Color(0xFF4CAF50),
                    extraContent: _buildHanacarakaList(), // <-- Sekarang ini valid
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // 3. Kartu Sandhangan (Ke Halaman Sub-menu)
          _buildMainSectionCard(
            context,
            title: 'Penanda Vokal (Sandhangan)',
            icon: Icons.translate_outlined,
            color: const Color(0xFF2196F3), // Blue
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SandhanganPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // 4. Kartu Pasangan (Ke Halaman Sub-menu)
          _buildMainSectionCard(
            context,
            title: 'Konsonan Penutup (Pasangan)',
            icon: Icons.link_outlined,
            color: const Color(0xFFFF9800), // Orange
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasanganPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // 5. Kartu Aksara Khusus (Ke Halaman Sub-menu)
          _buildMainSectionCard(
            context,
            title: 'Karakter Khusus (Murda & Rekan)',
            icon: Icons.star_border_outlined,
            color: const Color(0xFFE91E63), // Pink
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AksaraKhususPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // 6. Kartu Aksara Swara (Langsung ke Detail)
          _buildMainSectionCard(
            context,
            title: 'Vokal Mandiri (Aksara Swara)',
            icon: Icons.record_voice_over_outlined,
            color: const Color(0xFF9C27B0), // Purple
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GuideDetailPage(
                    title: 'Aksara Swara',
                    description: 'Karakter vokal mandiri adalah simbol vokal yang dapat berdiri sendiri dalam sistem tulisan Jawa, mencakup lima bentuk untuk bunyi a, i, u, é, dan o. Tidak seperti penanda vokal, karakter ini tidak bergantung pada karakter lain dan umumnya digunakan untuk menuliskan silabel vokal di permulaan kata.',
                    imagePath: 'assets/images/vokal.png',
                    color: Color(0xFF9C27B0),
                    imageFit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // 7. Kartu Angka & Pungtuasi (Ke Halaman Sub-menu)
          _buildMainSectionCard(
            context,
            title: 'Angka & Pungtuasi',
            icon: Icons.format_list_numbered_outlined,
            color: const Color(0xFF009688), // Teal
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AngkaPadaPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // --- Widget Bawaan Halaman Utama ---

  Widget _buildIntroCard() {
    return Card(
      color: const Color(0xFF1F223A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/images/header art.jpeg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.black.withOpacity(0.2),
                  child: const Icon(Icons.image_not_supported,
                      color: Colors.grey, size: 50),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Selamat datang di panduan Aksara Jawa. Halaman ini akan memandu Anda memahami komponen-komponen utama dalam sistem penulisan Jawa.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainSectionCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF1F223A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ketuk untuk mempelajari',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget khusus untuk list Hanacaraka
Widget _buildHanacarakaList() {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF4CAF50).withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFF4CAF50).withOpacity(0.3),
        width: 2,
      ),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ꦲ ꦤ ꦕ ꦫ ꦏ (ha na ca ra ka)',
          style: TextStyle(color: Colors.white, fontSize: 17, height: 1.8),
        ),
        Text(
          'ꦢ ꦠ ꦱ ꦮ ꦭ (da ta sa wa la)',
          style: TextStyle(color: Colors.white, fontSize: 17, height: 1.8),
        ),
        Text(
          'ꦥ ꦝ ꦗ ꦪ ꦚ (pa dha ja ya nya)',
          style: TextStyle(color: Colors.white, fontSize: 17, height: 1.8),
        ),
        Text(
          'ꦩ ꦒ ꦧ ꦛ ꦔ (ma ga ba tha nga)',
          style: TextStyle(color: Colors.white, fontSize: 17, height: 1.8),
        ),
      ],
    ),
  );
}

//======================================================================
// HALAMAN 2: Halaman Sub-Menu (Contoh: SandhanganPage)
//======================================================================

// --- Halaman Sub-Menu: Sandhangan ---
class SandhanganPage extends StatelessWidget {
  const SandhanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xFF2196F3);
    const String image = 'assets/images/sandhangan.png';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          _buildSubMenuSliverAppBar(context, 'Penanda Vokal (Sandhangan)'),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildIntroCard(
                'Penanda vokal merupakan simbol tambahan yang mengubah pengucapan vokal dari karakter utama. Beberapa penanda vokal yang penting meliputi:',
              ),
              _buildGuideItemCard(
                context,
                title: 'Wulu',
                description: 'Membuat bunyi vokal berubah ke "i". Misalnya, karakter "ka" (ꦏ) yang diberi wulu berubah menjadi "ki" (ꦏꦶ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              _buildGuideItemCard(
                context,
                title: 'Suku',
                description: 'Membuat bunyi vokal berubah ke "u". Misalnya, karakter "pa" (ꦥ) yang diberi suku berubah menjadi "pu" (ꦥꦸ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              _buildGuideItemCard(
                context,
                title: 'Pepet',
                description: 'Membuat bunyi vokal berubah ke "e" (bunyi seperti dalam "ember"). Misalnya, karakter "da" (ꦢ) yang diberi pepet berubah menjadi "de" (ꦢꦼ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              _buildGuideItemCard(
                context,
                title: 'Taling',
                description: 'Membuat bunyi vokal berubah ke "é" (bunyi seperti dalam "séga"). Misalnya, karakter "ra" (ꦫ) yang diberi taling berubah menjadi "ré" (ꦫꦺ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              _buildGuideItemCard(
                context,
                title: 'Taling Tarung',
                description: 'Membuat bunyi vokal berubah ke "o". Misalnya, karakter "ta" (ꦠ) yang diberi taling tarung berubah menjadi "to" (ꦠꦺꦴ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }
}

// --- Halaman Sub-Menu: Pasangan ---
class PasanganPage extends StatelessWidget {
  const PasanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color color = Color(0xFFFF9800);
    const String image = 'assets/images/pasangan.png';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          _buildSubMenuSliverAppBar(context, 'Konsonan Penutup (Pasangan)'),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildIntroCard(
                'Bentuk konsonan penutup adalah variasi dari karakter dasar yang digunakan untuk menghilangkan bunyi vokal bawaan dari karakter sebelumnya. Bentuk ini ditempatkan di bagian bawah karakter dasar untuk menulis silabel tertutup. Contoh implementasinya:',
              ),
              _buildGuideItemCard(
                context,
                title: 'Contoh 1: mba',
                description: 'Karakter "ma" (ꦩ) yang ditambahkan bentuk penutup "ba" (꧀ꦧ) menghasilkan "mba" (ꦩ꧀ꦧ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              _buildGuideItemCard(
                context,
                title: 'Contoh 2: kka',
                description: 'Karakter "ka" (ꦏ) yang ditambahkan bentuk penutup "ka" (꧀ꦏ) menghasilkan "kka" (ꦏ꧀ꦏ).',
                imagePath: image,
                color: color,
                imageFit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }
}

// --- Halaman Sub-Menu: Aksara Khusus ---
class AksaraKhususPage extends StatelessWidget {
  const AksaraKhususPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          _buildSubMenuSliverAppBar(context, 'Karakter Khusus'),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildIntroCard(
                'Dalam sistem tulisan Jawa terdapat dua kategori karakter istimewa:',
              ),
              _buildGuideItemCard(
                context,
                title: 'Aksara Murda',
                description: 'Memiliki fungsi serupa dengan huruf besar, dipakai untuk menuliskan karakter pembuka pada identitas seseorang, lokasi geografis, atau istilah yang memerlukan penghormatan khusus. Ada delapan karakter yang memiliki varian Murda.',
                imagePath: 'assets/images/murda.png',
                color: const Color(0xFFE91E63), // Pink
                imageFit: BoxFit.contain,
              ),
              _buildGuideItemCard(
                context,
                title: 'Aksara Rekan',
                description: 'Merupakan karakter-karakter untuk menuliskan bunyi-bunyi yang berasal dari bahasa luar (seperti bahasa Arab) yang tidak terdapat dalam bunyi asli bahasa Jawa.',
                imagePath: 'assets/images/rekan.png',
                color: const Color(0xFF795548), // Brown
                imageFit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }
}

// --- Halaman Sub-Menu: Angka & Pungtuasi ---
class AngkaPadaPage extends StatelessWidget {
  const AngkaPadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data untuk Pungtuasi
    const String pungtuasiDesc = 'Sistem tulisan Jawa juga memiliki seperangkat simbol pungtuasi tersendiri untuk mengatur jeda dan tekanan dalam teks. Beberapa simbol pungtuasi utama mencakup:';
    final List<String> bullets = [
      'Pada lingsa (꧈): Memiliki fungsi yang mirip dengan koma (,).',
      'Pada lungsi (꧉): Memiliki fungsi yang mirip dengan titik (.).',
      'Pada pangkat (꧁ ꧂): Memiliki fungsi yang mirip dengan tanda kutip (" ").',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          _buildSubMenuSliverAppBar(context, 'Angka & Pungtuasi'),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildIntroCard(
                'Sistem tulisan Jawa memiliki simbol tersendiri untuk angka dan tanda baca.',
              ),
              // Kartu 1: Angka
              _buildGuideItemCard(
                context,
                title: 'Aksara Wilangan (Angka)',
                description: 'Sistem angka dalam tulisan Jawa memiliki bentuk simbolnya sendiri yang khas. Sebagai ilustrasi, angka tiga direpresentasikan dengan "꧓", angka tujuh dengan "꧗", dan angka dua puluh dengan "꧒꧐".',
                imagePath: 'assets/images/wilangan.png',
                color: const Color(0xFF009688), // Teal
                imageFit: BoxFit.contain,
              ),
              // Kartu 2: Pungtuasi
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuideDetailPage(
                        title: 'Pada (Pungtuasi)',
                        description: pungtuasiDesc,
                        imagePath: 'assets/images/pada1.png',
                        imagePath2: 'assets/images/pada2.png', // Gambar kedua
                        color: const Color(0xFF607D8B), // Blue Grey
                        imageFit: BoxFit.contain,
                        extraBulletPoints: bullets, // Bullet points
                      ),
                    ),
                  );
                },
                child: Card(
                  color: const Color(0xFF1F223A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.3),
                          child: Row( // Menampilkan 2 gambar
                            children: [
                              Expanded(child: _buildImageHelper('assets/images/pada1.png', BoxFit.contain)),
                              const SizedBox(width: 2),
                              Expanded(child: _buildImageHelper('assets/images/pada2.png', BoxFit.contain)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCardTitle(
                              'Pada (Pungtuasi)',
                              const Color(0xFF607D8B),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pungtuasiDesc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }
}


//======================================================================
// WIDGET & HALAMAN GENERIK (Reusable)
//======================================================================

// --- Halaman 3: Halaman Detail Generik ---
class GuideDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String? imagePath2;
  final Color color;
  final BoxFit imageFit;
  final Widget? extraContent;
  final List<String>? extraBulletPoints;

  const GuideDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.imagePath2,
    required this.color,
    this.imageFit = BoxFit.cover,
    this.extraContent,
    this.extraBulletPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1F223A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Menampilkan gambar
                  (imagePath2 != null && imagePath2!.isNotEmpty)
                      ? Row(
                    children: [
                      Expanded(child: _buildImage(imagePath, imageFit)),
                      const SizedBox(width: 2),
                      Expanded(child: _buildImage(imagePath2!, imageFit)),
                    ],
                  )
                      : _buildImage(imagePath, imageFit),

                  // Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF121212).withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F223A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.8,
                        ),
                      ),
                    ),

                    // Konten Tambahan (misal: list hanacaraka)
                    if (extraContent != null) ...[
                      const SizedBox(height: 24),
                      extraContent!,
                    ],

                    // Bullet points (misal: pungtuasi)
                    if (extraBulletPoints != null &&
                        extraBulletPoints!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: color.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...extraBulletPoints!.map(
                                  (text) => _buildBulletItem(text, color),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // Helper untuk image di dalam class ini
  Widget _buildImage(String path, BoxFit fit) {
    return Image.asset(
      path,
      fit: fit,
      height: 300,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.black.withOpacity(0.3),
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 80,
          ),
        );
      },
    );
  }

  // Helper untuk bullet item
  Widget _buildBulletItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// --- Widget Generik: Kartu Item (di Halaman 2) ---
Widget _buildGuideItemCard(
    BuildContext context, {
      required String title,
      required String description,
      required String imagePath,
      required Color color,
      BoxFit imageFit = BoxFit.cover,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuideDetailPage(
              title: title,
              description: description,
              imagePath: imagePath,
              color: color,
              imageFit: imageFit,
            ),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF1F223A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image preview
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                height: 140,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3),
                child: _buildImageHelper(imagePath, imageFit),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCardTitle(title, color),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// --- Widget Generik: SliverAppBar (di Halaman 2) ---
Widget _buildSubMenuSliverAppBar(BuildContext context, String title) {
  return SliverAppBar(
    expandedHeight: 80,
    floating: false,
    pinned: true,
    backgroundColor: const Color(0xFF1F223A),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      centerTitle: true,
    ),
  );
}

// --- Widget Generik: Intro Card (di Halaman 2) ---
Widget _buildIntroCard(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    child: Card(
      color: const Color(0xFF1F223A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ),
    ),
  );
}

// --- Widget Generik: Helper Gambar ---
Widget _buildImageHelper(String path, BoxFit fit) {
  return Image.asset(
    path,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        color: Colors.black.withOpacity(0.2),
        child: Icon(
          Icons.image_not_supported,
          color: Colors.grey.shade700,
          size: 50,
        ),
      );
    },
  );
}

// --- Widget Generik: Title Kartu (di Halaman 2) ---
Widget _buildCardTitle(String title, Color color) {
  return Row(
    children: [
      Container(
        width: 4,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Icon(
        Icons.arrow_forward_ios,
        color: color,
        size: 16,
      ),
    ],
  );
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
//               child: Image.asset(
//                 'assets/images/header art.jpeg', // Changed from Image.network
//                 height: 200,
//                 fit: BoxFit.fitHeight,
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
//           _buildImageSection(
//             'assets/images/hanacaraka.jpg',
//             height: 250,
//             fit: BoxFit.cover,
//           ),
//           _buildParagraph(
//               'Masing-masing karakter ini membawa nilai filosofis tersendiri. Lima karakter awal, misalnya, dapat dimaknai sebagai representasi: \'Ha\' melambangkan Sang Pencipta, \'Na\' merepresentasikan manusia, \'Ca\' simbol dari pencerahan, \'Ra\' menggambarkan emosi, dan \'Ka\' mewakili konsep tindakan dan akibatnya.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Penanda Vokal dalam Tulisan Jawa'),
//           _buildParagraph(
//               'Penanda vokal merupakan simbol tambahan yang mengubah pengucapan vokal dari karakter utama. Beberapa penanda vokal yang penting meliputi:'),
//           _buildImageSection(
//             'assets/images/sandhangan.png',
//             height: 310,
//             fit: BoxFit.contain,
//           ),
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
//           _buildImageSection(
//             'assets/images/pasangan.png',
//             height: 350,
//             fit: BoxFit.contain,
//           ),
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
//           _buildImageSection(
//             'assets/images/murda.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint(
//               'Karakter Rekan: Merupakan karakter-karakter untuk menuliskan bunyi-bunyi yang berasal dari bahasa luar (seperti bahasa Arab) yang tidak terdapat dalam bunyi asli bahasa Jawa.'),
//           _buildImageSection(
//             'assets/images/rekan.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Karakter Vokal Mandiri'),
//           _buildParagraph(
//               'Karakter vokal mandiri adalah simbol vokal yang dapat berdiri sendiri dalam sistem tulisan Jawa, mencakup lima bentuk untuk bunyi a, i, u, é, dan o. Tidak seperti penanda vokal, karakter ini tidak bergantung pada karakter lain dan umumnya digunakan untuk menuliskan silabel vokal di permulaan kata.'),
//           const SizedBox(height: 20),
//           _buildImageSection(
//             'assets/images/vokal.png',
//             height: 50,
//             fit: BoxFit.contain,
//           ),
//           _buildSectionTitle('Sistem Angka dan Pungtuasi Jawa'),
//           _buildParagraph(
//               'Sistem angka dalam tulisan Jawa memiliki bentuk simbolnya sendiri yang khas. Sebagai ilustrasi, angka tiga direpresentasikan dengan "꧓", angka tujuh dengan "꧗", dan angka dua puluh dengan "꧒꧐".'),
//           _buildImageSection(
//             'assets/images/wilangan.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           _buildParagraph(
//               'Sistem tulisan Jawa juga memiliki seperangkat simbol pungtuasi tersendiri untuk mengatur jeda dan tekanan dalam teks. Beberapa simbol pungtuasi utama mencakup:'),
//           _buildBulletPoint(
//               'Pada lingsa (꧈): Memiliki fungsi yang mirip dengan koma (,).'),
//           _buildBulletPoint(
//               'Pada lungsi (꧉): Memiliki fungsi yang mirip dengan titik (.).'),
//           _buildBulletPoint(
//               'Pada pangkat (꧁ ꧂): Memiliki fungsi yang mirip dengan tanda kutip (" ").'),
//           _buildImageSection(
//             'assets/images/pada1.png',
//             height: 450,
//             fit: BoxFit.contain,
//           ),
//           _buildImageSection(
//             'assets/images/pada2.png',
//             height: 450,
//             fit: BoxFit.contain,
//           ),
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
//
//   // Tambahkan method ini di dalam class JavaneseGuidePage
//   Widget _buildImageSection(String imagePath, {
//     double height = 150,
//     double borderRadius = 12.0,
//     BoxFit fit = BoxFit.contain,
//     EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16.0),
//   }) {
//     return Padding(
//       padding: padding,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(borderRadius),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           child: Image.asset(
//             imagePath,
//             height: height,
//             width: double.infinity,
//             fit: fit,
//             errorBuilder: (context, error, stackTrace) {
//               return Container(
//                 height: height,
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//                 child: const Icon(
//                   Icons.image_not_supported,
//                   color: Colors.grey,
//                   size: 50,
//                 ),
//               );
//             },
//           ),
//         ),
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
