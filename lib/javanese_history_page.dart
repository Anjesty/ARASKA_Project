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
        padding: const EdgeInsets.all(16.0),
        children: [
          // Intro Card
          _buildIntroCard(),
          const SizedBox(height: 16),

          // Main Section Card
          _buildMainSectionCard(
            context,
            title: '1. Kisah Legendaris Aji Saka',
            icon: Icons.auto_stories,
            color: const Color(0xFF6B4EFF),
          ),
          const SizedBox(height: 16),

          // Section 2: Jejak Ilmiah
          _buildMainSectionCard(
            context,
            title: '2. Jejak Ilmiah (Paleografi)',
            icon: Icons.science,
            color: const Color(0xFF4ECDC4),
            isScientific: true,
          ),
          const SizedBox(height: 16),

          // Section Kesimpulan
          _buildConclusionCard(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    return Card(
      color: const Color(0xFF1F223A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B4EFF).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Color(0xFF6B4EFF),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Selamat datang di fitur Sejarah Aksara Jawa! Tahukah Anda? Aksara yang Anda pelajari dan gunakan di aplikasi ini memiliki dua sisi cerita asal-usul yang sangat menarik.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Ada kisah legendaris yang hidup di tengah masyarakat, dan ada pula jejak sejarah yang diteliti oleh para ilmuwan. Mari kita telusuri keduanya.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSectionCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        bool isScientific = false,
      }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => isScientific
                ? const ScientificHistoryPage()
                : const AjiSakaLegendPage(),
          ),
        );
      },
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
                      'Ketuk untuk menjelajahi cerita',
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

  Widget _buildConclusionCard() {
    return Card(
      color: const Color(0xFF1F223A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB74D).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    color: Color(0xFFFFB74D),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Kesimpulan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Legenda Aji Saka memberi kita makna filosofis yang mendalam tentang kesetiaan dan takdir.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Di sisi lain, jejak ilmiah memberi kita bukti sejarah yang nyata, menunjukkan bagaimana aksara ini berevolusi dan beradaptasi seiring perjalanan panjang peradaban di Nusantara.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail untuk Kisah Legendaris Aji Saka
class AjiSakaLegendPage extends StatelessWidget {
  const AjiSakaLegendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1F223A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Kisah Legendaris Aji Saka',
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Intro text untuk section ini
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: const Color(0xFF1F223A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Ini adalah cerita yang paling sering Anda dengar dan menjadi bagian dari budaya Jawa. Kisah ini berpusat pada seorang pahlawan bijaksana bernama Aji Saka.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),

              // Card untuk setiap sub-bagian cerita
              _buildStoryCard(
                context,
                title: 'Dua Abdi Setia',
                description: 'Aji Saka dikisahkan memiliki dua abdi yang sangat setia, bernama Dora dan Sembodo.',
                imagePath: 'assets/images/legenda1.png',
                color: const Color(0xFF6B4EFF),
              ),

              _buildStoryCard(
                context,
                title: 'Amanat Pusaka',
                description: 'Suatu ketika, Aji Saka harus pergi dan meninggalkan pusakanya (sering dikisahkan sebagai keris) kepada Sembodo. Pesannya sangat tegas: "Jangan serahkan pusaka ini kepada siapa pun, kecuali aku sendiri yang mengambilnya".',
                imagePath: 'assets/images/legenda2.png',
                color: const Color(0xFFFF6B9D),
              ),

              _buildStoryCard(
                context,
                title: 'Tragedi Kesetiaan',
                description: 'Beberapa waktu kemudian, Aji Saka mengutus Dora untuk mengambil pusaka tersebut. Di sinilah terjadi tragedi. Sembodo menolak memberikannya karena ia memegang teguh sumpah dan amanat Aji Saka. Di sisi lain, Dora juga bersikeras menjalankan perintah terbaru dari tuannya.',
                imagePath: 'assets/images/legenda3.png',
                color: const Color(0xFFFFB74D),
              ),

              _buildStoryCard(
                context,
                title: 'Lahirnya 20 Aksara',
                description: 'Karena keduanya merasa menjalankan tugas dan sama-sama setia, mereka bertarung. Karena keduanya sama-sama sakti (padha jayanya), pertarungan itu berakhir dengan tewasnya mereka berdua (maga bathanga). Aji Saka, yang menemukan kedua abdinya tewas, sangat bersedih. Untuk mengenang kesetiaan dan tragedi tersebut, ia menciptakan 20 aksara yang merangkum keseluruhan cerita itu.',
                imagePath: 'assets/images/legenda4.png',
                color: const Color(0xFF4ECDC4),
                showHanacaraka: true,
              ),

              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard(
      BuildContext context, {
        required String title,
        required String description,
        required String imagePath,
        required Color color,
        bool showHanacaraka = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoryDetailPage(
                title: title,
                description: description,
                imagePath: imagePath,
                color: color,
                showHanacaraka: showHanacaraka,
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
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
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
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    ),
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
}

// Halaman Detail untuk setiap story card
class StoryDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final bool showHanacaraka;

  const StoryDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    this.showHanacaraka = false,
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
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
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
                  ),
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

                    // Hanacaraka list (jika diperlukan)
                    if (showHanacaraka) ...[
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
                            Row(
                              children: [
                                Icon(Icons.format_list_bulleted, color: color),
                                const SizedBox(width: 8),
                                const Text(
                                  'Urutan Hanacaraka:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildHanacarakaItem('Ha Na Ca Ra Ka', 'Ada utusan'),
                            _buildHanacarakaItem('Da Ta Sa Wa La', 'Saling bertengkar'),
                            _buildHanacarakaItem('Pa Dha Ja Ya Nya', 'Sama-sama saktinya'),
                            _buildHanacarakaItem('Ma Ga Ba Tha Nga', 'Keduanya menjadi mayat'),
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

  Widget _buildHanacarakaItem(String aksara, String meaning) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.5,
                  fontFamily: 'Roboto',
                ),
                children: [
                  TextSpan(
                    text: aksara,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(text: ' - '),
                  TextSpan(text: meaning),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Detail untuk Jejak Ilmiah (Paleografi)
class ScientificHistoryPage extends StatelessWidget {
  const ScientificHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF1F223A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Jejak Ilmiah (Paleografi)',
                style: TextStyle(fontSize: 18),
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Intro text untuk section ini
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: const Color(0xFF1F223A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Selain legenda, para ilmuwan memiliki penjelasan ilmiah melalui studi Paleografi, yaitu ilmu yang mempelajari bentuk tulisan kuno. Menurut pendekatan ilmiah, Aksara Jawa tidak diciptakan secara tiba-tiba. Aksara ini adalah hasil evolusi panjang selama ribuan tahun.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),

              // Card untuk setiap tahap evolusi
              _buildEvolutionCard(
                context,
                title: 'Akar dari India',
                description: 'Perjalanan aksara ini dimulai dari Aksara Brahmi di India. Aksara ini kemudian berkembang menjadi Aksara Pallawa di India Selatan.',
                imagePath: 'assets/images/palawa.jpg',
                color: const Color(0xFF4ECDC4),
              ),

              _buildEvolutionCard(
                context,
                title: 'Masuk ke Nusantara',
                description: 'Aksara Pallawa inilah yang pertama kali masuk ke Nusantara, dibawa melalui jalur perdagangan dan penyebaran agama. Bukti tertuanya adalah prasasti Yupa di Kalimantan Timur dan prasasti-prasasti dari Kerajaan Tarumanegara.',
                imagePath: 'assets/images/yupa.jpg',
                color: const Color(0xFF6B4EFF),
              ),

              _buildEvolutionCard(
                context,
                title: 'Menjadi Aksara Kawi (Jawa Kuno)',
                description: 'Di Jawa, Aksara Pallawa perlahan beradaptasi dengan bahasa lokal dan berkembang menjadi Aksara Kawi. Aksara ini digunakan secara luas pada periode kerajaan Hindu-Buddha (sekitar abad 8-15 M). Buktinya ada di banyak prasasti, seperti Prasasti Dinoyo dan prasasti-prasasti dari era Raja Airlangga.',
                imagePath: 'assets/images/dinoyo.jpg',
                imagePath2: 'assets/images/kawi.jpg',
                color: const Color(0xFFFF6B9D),
                isDoubleImage: true,
              ),

              _buildEvolutionCard(
                context,
                title: 'Menjadi Aksara Jawa Baru (Hanacaraka)',
                description: 'Aksara Kawi terus berevolusi. Melalui era Majapahit (sekitar 1250-1450 M), bentuknya terus berubah hingga akhirnya menjadi Aksara Jawa Baru (Hanacaraka) yang kita gunakan saat ini, yang diperkirakan mulai terbentuk sejak abad ke-15.',
                imagePath: 'assets/images/hanacaraka.jpg',
                color: const Color(0xFFFFB74D),
              ),

              // Studi Kasus Card
              _buildCaseStudyCard(context),

              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildEvolutionCard(
      BuildContext context, {
        required String title,
        required String description,
        required String imagePath,
        String? imagePath2,
        required Color color,
        bool isDoubleImage = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScientificDetailPage(
                title: title,
                description: description,
                imagePath: imagePath,
                imagePath2: imagePath2 ?? '',
                color: color,
                isDoubleImage: isDoubleImage,
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
                  child: isDoubleImage && imagePath2 != null && imagePath2.isNotEmpty
                      ? Row(
                    children: [
                      Expanded(child: _buildImage(imagePath)),
                      const SizedBox(width: 2),
                      Expanded(child: _buildImage(imagePath2)),
                    ],
                  )
                      : _buildImage(imagePath),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    ),
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

  // ============== BAGIAN BARU YANG DITAMBAHKAN ==============

  Widget _buildCaseStudyCard(BuildContext context) {
    // Data spesifik untuk studi kasus
    const String title = 'Studi Kasus: Evolusi Aksara Kwadrat';
    const String description = 'Penelitian ilmiah bisa sangat detail. Contohnya, penelitian oleh Titi Surti Nastiti (seorang ahli epigrafi) meneliti gaya "Aksara Kwadrat"...';
    const String fullDescription = 'Penelitian ilmiah bisa sangat detail. Contohnya, penelitian oleh Titi Surti Nastiti (seorang ahli epigrafi) meneliti gaya "Aksara Kwadrat" (gaya aksara yang bentuknya kotak-kotak dan dekoratif).';
    const String imagePath = 'assets/images/jalatunda1.jpg';
    const String imagePath2 = 'assets/images/jalatunda2.jpg';
    const Color color = Color(0xFFE57373); // Warna baru untuk studi kasus
    const List<String> bullets = [
      'Orang sering mengira aksara gaya ini hanya ada di zaman Kerajaan Kadiri (abad ke-12). Namun, penelitian paleografi membuktikan aksara ini jauh lebih tua.',
      'Bentuk paling awalnya ditemukan di Petirtaan Jalatunda, yang berasal dari tahun 977 M. Ini adalah era sebelum Kadiri, yaitu masa Raja Makuțawangśawarddhana (ayah dari Dharmawangsa Tguh).',
      'Ini membuktikan bahwa Aksara Jawa terus berkembang secara perlahan dan berkesinambungan dari satu era ke era berikutnya.',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScientificDetailPage(
                title: title,
                description: fullDescription, // Kirim deskripsi lengkap
                imagePath: imagePath,
                imagePath2: imagePath2,
                color: color,
                isDoubleImage: true,
                extraBulletPoints: bullets, // Kirim bullet points
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
                  child: Row(
                    children: [
                      Expanded(child: _buildImage(imagePath)),
                      const SizedBox(width: 2),
                      Expanded(child: _buildImage(imagePath2)),
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description, // Deskripsi singkat
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

  // Helper untuk image di dalam class ini
  Widget _buildImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      height: 140,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.black.withOpacity(0.2),
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey.shade700,
            size: 40,
          ),
        );
      },
    );
  }
}

// ============== CLASS BARU YANG DITAMBAHKAN ==============

// Halaman Detail untuk setiap evolution card
class ScientificDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String imagePath2;
  final Color color;
  final bool isDoubleImage;
  final List<String>? extraBulletPoints;

  const ScientificDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.imagePath2,
    required this.color,
    this.isDoubleImage = false,
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
                  isDoubleImage
                      ? Row(
                    children: [
                      Expanded(child: _buildImage(imagePath)),
                      const SizedBox(width: 2),
                      Expanded(child: _buildImage(imagePath2)),
                    ],
                  )
                      : _buildImage(imagePath),

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

                    // Bullet points (jika ada)
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
                            Row(
                              children: [
                                Icon(Icons.fact_check_outlined, color: color),
                                const SizedBox(width: 8),
                                const Text(
                                  'Poin Penelitian:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Membuat list bullet point secara dinamis
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
  Widget _buildImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
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
              textAlign: TextAlign.justify,
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
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // Intro Card
//           _buildIntroCard(),
//           const SizedBox(height: 16),
//
//           // Main Section Card
//           _buildMainSectionCard(
//             context,
//             title: '1. Kisah Legendaris Aji Saka',
//             icon: Icons.auto_stories,
//             color: const Color(0xFF6B4EFF),
//           ),
//           const SizedBox(height: 16),
//
//           // Placeholder untuk section berikutnya
//           _buildPlaceholderText('(Section lainnya akan ditambahkan setelah persetujuan)'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildIntroCard() {
//     return Card(
//       color: const Color(0xFF1F223A),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF6B4EFF).withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(
//                     Icons.info_outline,
//                     color: Color(0xFF6B4EFF),
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 const Expanded(
//                   child: Text(
//                     'Selamat Datang!',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Selamat datang di fitur Sejarah Aksara Jawa! Tahukah Anda? Aksara yang Anda pelajari dan gunakan di aplikasi ini memiliki dua sisi cerita asal-usul yang sangat menarik.',
//               textAlign: TextAlign.justify,
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 15,
//                 height: 1.6,
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'Ada kisah legendaris yang hidup di tengah masyarakat, dan ada pula jejak sejarah yang diteliti oleh para ilmuwan. Mari kita telusuri keduanya.',
//               textAlign: TextAlign.justify,
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 15,
//                 height: 1.6,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMainSectionCard(
//       BuildContext context, {
//         required String title,
//         required IconData icon,
//         required Color color,
//       }) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const AjiSakaLegendPage(),
//           ),
//         );
//       },
//       child: Card(
//         color: const Color(0xFF1F223A),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 4,
//         child: Container(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: color,
//                   size: 32,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Ketuk untuk menjelajahi cerita',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.6),
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 color: color,
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPlaceholderText(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.white.withOpacity(0.4),
//           fontSize: 14,
//           fontStyle: FontStyle.italic,
//         ),
//       ),
//     );
//   }
// }
//
// // Halaman Detail untuk Kisah Legendaris Aji Saka
// class AjiSakaLegendPage extends StatelessWidget {
//   const AjiSakaLegendPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 80,
//             floating: false,
//             pinned: true,
//             backgroundColor: const Color(0xFF1F223A),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.pop(context),
//             ),
//             flexibleSpace: const FlexibleSpaceBar(
//               title: Text(
//                 'Kisah Legendaris Aji Saka',
//                 style: TextStyle(fontSize: 18),
//               ),
//               centerTitle: true,
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate([
//               // Intro text untuk section ini
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Card(
//                   color: const Color(0xFF1F223A),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text(
//                       'Ini adalah cerita yang paling sering Anda dengar dan menjadi bagian dari budaya Jawa. Kisah ini berpusat pada seorang pahlawan bijaksana bernama Aji Saka.',
//                       textAlign: TextAlign.justify,
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 15,
//                         height: 1.6,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Card untuk setiap sub-bagian cerita
//               _buildStoryCard(
//                 context,
//                 title: 'Dua Abdi Setia',
//                 description: 'Aji Saka dikisahkan memiliki dua abdi yang sangat setia, bernama Dora dan Sembodo.',
//                 imagePath: 'assets/images/legenda1.png',
//                 color: const Color(0xFF6B4EFF),
//               ),
//
//               _buildStoryCard(
//                 context,
//                 title: 'Amanat Pusaka',
//                 description: 'Suatu ketika, Aji Saka harus pergi dan meninggalkan pusakanya (sering dikisahkan sebagai keris) kepada Sembodo. Pesannya sangat tegas: "Jangan serahkan pusaka ini kepada siapa pun, kecuali aku sendiri yang mengambilnya".',
//                 imagePath: 'assets/images/legenda2.png',
//                 color: const Color(0xFFFF6B9D),
//               ),
//
//               _buildStoryCard(
//                 context,
//                 title: 'Tragedi Kesetiaan',
//                 description: 'Beberapa waktu kemudian, Aji Saka mengutus Dora untuk mengambil pusaka tersebut. Di sinilah terjadi tragedi. Sembodo menolak memberikannya karena ia memegang teguh sumpah dan amanat Aji Saka. Di sisi lain, Dora juga bersikeras menjalankan perintah terbaru dari tuannya.',
//                 imagePath: 'assets/images/legenda3.png',
//                 color: const Color(0xFFFFB74D),
//               ),
//
//               _buildStoryCard(
//                 context,
//                 title: 'Lahirnya 20 Aksara',
//                 description: 'Karena keduanya merasa menjalankan tugas dan sama-sama setia, mereka bertarung. Karena keduanya sama-sama sakti (padha jayanya), pertarungan itu berakhir dengan tewasnya mereka berdua (maga bathanga). Aji Saka, yang menemukan kedua abdinya tewas, sangat bersedih. Untuk mengenang kesetiaan dan tragedi tersebut, ia menciptakan 20 aksara yang merangkum keseluruhan cerita itu.',
//                 imagePath: 'assets/images/legenda4.png',
//                 color: const Color(0xFF4ECDC4),
//                 showHanacaraka: true,
//               ),
//
//               const SizedBox(height: 16),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStoryCard(
//       BuildContext context, {
//         required String title,
//         required String description,
//         required String imagePath,
//         required Color color,
//         bool showHanacaraka = false,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => StoryDetailPage(
//                 title: title,
//                 description: description,
//                 imagePath: imagePath,
//                 color: color,
//                 showHanacaraka: showHanacaraka,
//               ),
//             ),
//           );
//         },
//         child: Card(
//           color: const Color(0xFF1F223A),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 3,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image preview
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//                 child: Container(
//                   height: 140,
//                   width: double.infinity,
//                   color: Colors.black.withOpacity(0.3),
//                   child: Image.asset(
//                     imagePath,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.black.withOpacity(0.2),
//                         child: Icon(
//                           Icons.image_not_supported,
//                           color: Colors.grey.shade700,
//                           size: 50,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//
//               // Content
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 4,
//                           height: 24,
//                           decoration: BoxDecoration(
//                             color: color,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           Icons.arrow_forward_ios,
//                           color: color,
//                           size: 16,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       description,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         color: Colors.white60,
//                         fontSize: 14,
//                         height: 1.4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Halaman Detail untuk setiap story card
// class StoryDetailPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imagePath;
//   final Color color;
//   final bool showHanacaraka;
//
//   const StoryDetailPage({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     required this.color,
//     this.showHanacaraka = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 300,
//             floating: false,
//             pinned: true,
//             backgroundColor: const Color(0xFF1F223A),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.pop(context),
//             ),
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Image.asset(
//                     imagePath,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.black.withOpacity(0.3),
//                         child: const Icon(
//                           Icons.image_not_supported,
//                           color: Colors.grey,
//                           size: 80,
//                         ),
//                       );
//                     },
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           const Color(0xFF121212).withOpacity(0.8),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate([
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title
//                     Row(
//                       children: [
//                         Container(
//                           width: 6,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: color,
//                             borderRadius: BorderRadius.circular(3),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//
//                     // Description
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF1F223A),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Text(
//                         description,
//                         textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 16,
//                           height: 1.8,
//                         ),
//                       ),
//                     ),
//
//                     // Hanacaraka list (jika diperlukan)
//                     if (showHanacaraka) ...[
//                       const SizedBox(height: 24),
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: color.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: color.withOpacity(0.3),
//                             width: 2,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.format_list_bulleted, color: color),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   'Urutan Hanacaraka:',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             _buildHanacarakaItem('Ha Na Ca Ra Ka', 'Ada utusan'),
//                             _buildHanacarakaItem('Da Ta Sa Wa La', 'Saling bertengkar'),
//                             _buildHanacarakaItem('Pa Dha Ja Ya Nya', 'Sama-sama saktinya'),
//                             _buildHanacarakaItem('Ma Ga Ba Tha Nga', 'Keduanya menjadi mayat'),
//                           ],
//                         ),
//                       ),
//                     ],
//
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHanacarakaItem(String aksara, String meaning) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Row(
//         children: [
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 15,
//                   height: 1.5,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: aksara,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const TextSpan(text: ' - '),
//                   TextSpan(text: meaning),
//                 ],
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
//       body: ListView(
//         padding: const EdgeInsets.all(24.0),
//         children: [
//           _buildParagraph(
//               'Selamat datang di fitur Sejarah Aksara Jawa! Tahukah Anda? Aksara yang Anda pelajari dan gunakan di aplikasi ini memiliki dua sisi cerita asal-usul yang sangat menarik.'),
//           _buildParagraph(
//               'Ada kisah legendaris yang hidup di tengah masyarakat, dan ada pula jejak sejarah yang diteliti oleh para ilmuwan. Mari kita telusuri keduanya.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('1. Kisah Legendaris Aji Saka'),
//           _buildParagraph(
//               'Ini adalah cerita yang paling sering Anda dengar dan menjadi bagian dari budaya Jawa. Kisah ini berpusat pada seorang pahlawan bijaksana bernama Aji Saka.'),
//           _buildImageSection(
//             'assets/images/legenda1.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Dua Abdi Setia',
//               'Aji Saka dikisahkan memiliki dua abdi yang sangat setia, bernama Dora dan Sembodo.'),
//           _buildImageSection(
//             'assets/images/legenda2.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Amanat Pusaka',
//               'Suatu ketika, Aji Saka harus pergi dan meninggalkan pusakanya (sering dikisahkan sebagai keris) kepada Sembodo. Pesannya sangat tegas: "Jangan serahkan pusaka ini kepada siapa pun, kecuali aku sendiri yang mengambilnya".'),
//           _buildImageSection(
//             'assets/images/legenda3.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Tragedi Kesetiaan',
//               'Beberapa waktu kemudian, Aji Saka mengutus Dora untuk mengambil pusaka tersebut. Di sinilah terjadi tragedi. Sembodo menolak memberikannya karena ia memegang teguh sumpah dan amanat Aji Saka. Di sisi lain, Dora juga bersikeras menjalankan perintah terbaru dari tuannya.'),
//           _buildImageSection(
//             'assets/images/legenda4.png',
//             height: 250,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Lahirnya 20 Aksara',
//               'Karena keduanya merasa menjalankan tugas dan sama-sama setia, mereka bertarung. Karena keduanya sama-sama sakti (padha jayanya), pertarungan itu berakhir dengan tewasnya mereka berdua (maga bathanga). Aji Saka, yang menemukan kedua abdinya tewas, sangat bersedih. Untuk mengenang kesetiaan dan tragedi tersebut, ia menciptakan 20 aksara yang merangkum keseluruhan cerita itu. Inilah yang kita kenal sebagai urutan Hanacaraka:'),
//           _buildHanacarakaList(),
//           const SizedBox(height: 20),
//           _buildSectionTitle('2. Jejak Ilmiah (Paleografi)'),
//           _buildParagraph(
//               'Selain legenda, para ilmuwan memiliki penjelasan ilmiah melalui studi Paleografi, yaitu ilmu yang mempelajari bentuk tulisan kuno. Menurut pendekatan ilmiah, Aksara Jawa tidak diciptakan secara tiba-tiba. Aksara ini adalah hasil evolusi panjang selama ribuan tahun.'),
//           _buildImageSection(
//             'assets/images/palawa.jpg',
//             height: 400,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Akar dari India',
//               'Perjalanan aksara ini dimulai dari Aksara Brahmi di India. Aksara ini kemudian berkembang menjadi Aksara Pallawa di India Selatan.'),
//           _buildImageSection(
//             'assets/images/yupa.jpg',
//             height: 300,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Masuk ke Nusantara',
//               'Aksara Pallawa inilah yang pertama kali masuk ke Nusantara, dibawa melalui jalur perdagangan dan penyebaran agama. Bukti tertuanya adalah prasasti Yupa di Kalimantan Timur dan prasasti-prasasti dari Kerajaan Tarumanegara.'),
//           _buildDoubleImageRow(
//             'assets/images/dinoyo.jpg',
//             'assets/images/kawi.jpg',
//             height: 250,
//           ),
//           _buildBulletPoint('Menjadi Aksara Kawi (Jawa Kuno)',
//               'Di Jawa, Aksara Pallawa perlahan beradaptasi dengan bahasa lokal dan berkembang menjadi Aksara Kawi. Aksara ini digunakan secara luas pada periode kerajaan Hindu-Buddha (sekitar abad 8-15 M). Buktinya ada di banyak prasasti, seperti Prasasti Dinoyo dan prasasti-prasasti dari era Raja Airlangga.'),
//           _buildImageSection(
//             'assets/images/hanacaraka.jpg',
//             height: 300,
//             fit: BoxFit.contain,
//           ),
//           _buildBulletPoint('Menjadi Aksara Jawa Baru (Hanacaraka)',
//               'Aksara Kawi terus berevolusi. Melalui era Majapahit (sekitar 1250-1450 M), bentuknya terus berubah hingga akhirnya menjadi Aksara Jawa Baru (Hanacaraka) yang kita gunakan saat ini, yang diperkirakan mulai terbentuk sejak abad ke-15.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Studi Kasus: Evolusi Aksara Kwadrat'),
//           _buildParagraph(
//               'Penelitian ilmiah bisa sangat detail. Contohnya, penelitian oleh Titi Surti Nastiti (seorang ahli epigrafi) meneliti gaya "Aksara Kwadrat" (gaya aksara yang bentuknya kotak-kotak dan dekoratif).'),
//           _buildDoubleImageRow(
//             'assets/images/jalatunda1.jpg',
//             'assets/images/jalatunda2.jpg',
//             height: 200,
//           ),
//           _buildBulletPoint(null,
//               'Orang sering mengira aksara gaya ini hanya ada di zaman Kerajaan Kadiri (abad ke-12). Namun, penelitian paleografi membuktikan aksara ini jauh lebih tua.'),
//           _buildBulletPoint(null,
//               'Bentuk paling awalnya ditemukan di Petirtaan Jalatunda, yang berasal dari tahun 977 M. Ini adalah era sebelum Kadiri, yaitu masa Raja Makuțawangśawarddhana (ayah dari Dharmawangsa Tguh).'),
//           _buildBulletPoint(null,
//               'Ini membuktikan bahwa Aksara Jawa terus berkembang secara perlahan dan berkesinambungan dari satu era ke era berikutnya.'),
//           const SizedBox(height: 20),
//           _buildSectionTitle('Kesimpulan'),
//           _buildParagraph(
//               'Legenda Aji Saka memberi kita makna filosofis yang mendalam tentang kesetiaan dan takdir.'),
//           _buildParagraph(
//               'Di sisi lain, jejak ilmiah memberi kita bukti sejarah yang nyata, menunjukkan bagaimana aksara ini berevolusi dan beradaptasi seiring perjalanan panjang peradaban di Nusantara.'),
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
//   Widget _buildBulletPoint(String? title, String content) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
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
//             child: RichText(
//               text: TextSpan(
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                   height: 1.5,
//                   fontFamily: 'Roboto', // Ensure consistent font
//                 ),
//                 children: [
//                   if (title != null)
//                     TextSpan(
//                       text: '$title: ',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   TextSpan(text: content),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHanacarakaList() {
//     return Container(
//       margin: const EdgeInsets.only(top: 8, left: 24),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Ha Na Ca Ra Ka (Ada utusan)',
//               style: TextStyle(color: Colors.white70, fontSize: 16)),
//           SizedBox(height: 4),
//           Text('Da Ta Sa Wa La (Saling bertengkar)',
//               style: TextStyle(color: Colors.white70, fontSize: 16)),
//           SizedBox(height: 4),
//           Text('Pa Dha Ja Ya Nya (Sama-sama saktinya)',
//               style: TextStyle(color: Colors.white70, fontSize: 16)),
//           SizedBox(height: 4),
//           Text('Ma Ga Ba Tha Nga (Keduanya menjadi mayat)',
//               style: TextStyle(color: Colors.white70, fontSize: 16)),
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
//
//   Widget _buildDoubleImageRow(String imagePath1, String imagePath2, {
//     double height = 150,
//     double spacing = 12.0,
//     double borderRadius = 12.0,
//     BoxFit fit = BoxFit.contain,
//     EdgeInsets padding = const EdgeInsets.symmetric(vertical: 16.0),
//   }) {
//     return Padding(
//       padding: padding,
//       child: Row(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(borderRadius),
//               child: Container(
//                 height: height,
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//                 child: Image.asset(
//                   imagePath1,
//                   height: height,
//                   fit: fit,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: height,
//                       color: Colors.black.withOpacity(0.2),
//                       child: const Icon(Icons.image_not_supported, color: Colors.grey),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: spacing), // Jarak antar gambar
//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(borderRadius),
//               child: Container(
//                 height: height,
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//                 child: Image.asset(
//                   imagePath2,
//                   height: height,
//                   fit: fit,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: height,
//                       color: Colors.black.withOpacity(0.2),
//                       child: const Icon(Icons.image_not_supported, color: Colors.grey),
//                     );
//                   },
//                 ),
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
