import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'widgets/app_header.dart';
import 'main.dart';
import 'login_page.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final AudioPlayer _player = AudioPlayer();
  bool _isSidebarVisible = true;

  final List<Map<String, String>> jawiLetters = [
    {'image': 'assets/images/alif.png', 'sound': 'alif.mp3', 'label': 'Alif'},
    {'image': 'assets/images/ba.png', 'sound': 'ba.mp3', 'label': 'Ba'},
    {'image': 'assets/images/ta.png', 'sound': 'ta.mp3', 'label': 'Ta'},
    {
      'image': 'assets/images/ta-marbutah.png',
      'sound': 'ta-marbutah.mp3',
      'label': 'Ta Marbutah',
    },
    {'image': 'assets/images/tha.png', 'sound': 'tha.mp3', 'label': 'Tha'},
    {'image': 'assets/images/jim.png', 'sound': 'jim.mp3', 'label': 'Jim'},
    {'image': 'assets/images/ca.png', 'sound': 'ca.mp3', 'label': 'Ca'},
    {'image': 'assets/images/ha.png', 'sound': 'ha.mp3', 'label': 'Ha'},
    {'image': 'assets/images/kho.png', 'sound': 'kho.mp3', 'label': 'Kho'},
    {'image': 'assets/images/dal.png', 'sound': 'dal.mp3', 'label': 'Dal'},
    {'image': 'assets/images/zal.png', 'sound': 'zal.mp3', 'label': 'Zal'},
    {'image': 'assets/images/ra.png', 'sound': 'ra.mp3', 'label': 'Ra'},
    {'image': 'assets/images/zai.png', 'sound': 'zai.mp3', 'label': 'Zai'},
    {'image': 'assets/images/sin.png', 'sound': 'sin.mp3', 'label': 'Sin'},
    {'image': 'assets/images/shin.png', 'sound': 'shin.mp3', 'label': 'Shin'},
    {'image': 'assets/images/sad.png', 'sound': 'sad.mp3', 'label': 'Sad'},
    {'image': 'assets/images/dad.png', 'sound': 'dad.mp3', 'label': 'Dad'},
    {'image': 'assets/images/tho.png', 'sound': 'tho.mp3', 'label': 'Tho'},
    {'image': 'assets/images/dzo.png', 'sound': 'dzo.mp3', 'label': 'Dzo'},
    {'image': 'assets/images/ain.png', 'sound': 'ain.mp3', 'label': 'Ain'},
    {
      'image': 'assets/images/ghain.png',
      'sound': 'ghain.mp3',
      'label': 'Ghain',
    },
    {'image': 'assets/images/nga.png', 'sound': 'nga.mp3', 'label': 'Nga'},
    {'image': 'assets/images/fa.png', 'sound': 'fa.mp3', 'label': 'Fa'},
    {'image': 'assets/images/pa.png', 'sound': 'pa.mp3', 'label': 'Pa'},
    {'image': 'assets/images/qof.png', 'sound': 'qof.mp3', 'label': 'Qof'},
    {'image': 'assets/images/kaf.png', 'sound': 'kaf.mp3', 'label': 'Kaf'},
    {'image': 'assets/images/ga.png', 'sound': 'ga.mp3', 'label': 'Ga'},
    {'image': 'assets/images/lam.png', 'sound': 'lam.mp3', 'label': 'Lam'},
    {'image': 'assets/images/mim.png', 'sound': 'mim.mp3', 'label': 'Mim'},
    {'image': 'assets/images/nun.png', 'sound': 'nun.mp3', 'label': 'Nun'},
    {'image': 'assets/images/wau.png', 'sound': 'wau.mp3', 'label': 'Wau'},
    {'image': 'assets/images/va.png', 'sound': 'va.mp3', 'label': 'Va'},
    {
      'image': 'assets/images/ha-bulat.png',
      'sound': 'ha-bulat.mp3',
      'label': 'Ha',
    },
    {
      'image': 'assets/images/lam-alif.png',
      'sound': 'lam-alif.mp3',
      'label': 'Lam Alif',
    },
    {
      'image': 'assets/images/hamzah.png',
      'sound': 'hamzah.mp3',
      'label': 'Hamzah',
    },
    {'image': 'assets/images/ya.png', 'sound': 'ya.mp3', 'label': 'Ya'},
    {'image': 'assets/images/ye.png', 'sound': 'ye.mp3', 'label': 'Ye'},
    {'image': 'assets/images/nya.png', 'sound': 'nya.mp3', 'label': 'Nya'},
  ];

  void _playSound(String soundFile) async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/$soundFile'));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F6FF),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/jawi_bg1.jpg', fit: BoxFit.cover),
          ),

          Column(
            children: [
              AppHeader(
                activeMenu: "Learn",
                onMenuChanged: (menu) {
                  if (menu == "Home") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else if (menu == "Log in") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                },
                parentContext: context,
              ),

              Expanded(
                child: Row(
                  children: [
                    // Sidebar
                    if (_isSidebarVisible)
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(
                          left: 20,
                          top: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 10,
                                top: 15,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Topik Pembelajaran',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0D47A1),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSidebarVisible = false;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                children: [
                                  _buildTopicItem(
                                    'Topik 1',
                                    'Jom Belajar: Mengenal Huruf Jawi',
                                    Icons.abc_outlined,
                                    true, // Currently active
                                  ),
                                  _buildTopicItem(
                                    'Topik 2',
                                    'Jom Belajar: Petua Menyambung Huruf',
                                    Icons.link_outlined,
                                    false,
                                  ),
                                  _buildTopicItem(
                                    'Topik 3',
                                    'Jom Belajar: Cara Menyambung Huruf',
                                    Icons.connect_without_contact_outlined,
                                    false,
                                  ),
                                  _buildTopicItem(
                                    'Topik 4',
                                    'Jom Imbas: Kaedah Menyambung Huruf',
                                    Icons.psychology_outlined,
                                    false,
                                  ),
                                  _buildTopicItem(
                                    'Topik 5',
                                    'Jom Berlatih: Latihan Pengukuhan',
                                    Icons.quiz_outlined,
                                    false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Main content area
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),

                              // Header row with menu button and title
                              Row(
                                children: [
                                  // Menu button when sidebar is hidden
                                  if (!_isSidebarVisible)
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isSidebarVisible = true;
                                        });
                                      },
                                      icon: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26.withValues(
                                                alpha: 0.1,
                                              ),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.menu,
                                          color: Color(0xFF0D47A1),
                                          size: 24,
                                        ),
                                      ),
                                    ),

                                  // Add spacing between button and title when button is visible
                                  if (!_isSidebarVisible)
                                    const SizedBox(width: 16),

                                  // Title
                                  Expanded(
                                    child: Text(
                                      'Jom Belajar: Mengenal Huruf Jawi',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(
                                          221,
                                          255,
                                          255,
                                          255,
                                        ),
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1, 1),
                                            blurRadius: 15,
                                            color: Color.fromARGB(
                                              255,
                                              31,
                                              31,
                                              31,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign:
                                          _isSidebarVisible
                                              ? TextAlign.center
                                              : TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),

                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(20),
                                  itemCount: jawiLetters.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        crossAxisSpacing: 35,
                                        mainAxisSpacing: 35,
                                        childAspectRatio: 1,
                                      ),
                                  itemBuilder: (context, index) {
                                    final item = jawiLetters[index];
                                    final imagePath = item['image'] ?? '';
                                    final soundFile = item['sound'] ?? '';

                                    return GestureDetector(
                                      onTap: () {
                                        if (soundFile.isNotEmpty)
                                          _playSound(soundFile);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26.withValues(
                                                alpha: 0.1,
                                              ),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  15.0,
                                                ),
                                                child: Image.asset(
                                                  imagePath,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),

                                            // 👇 TEXT UNDER IMAGE
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 15,
                                              ),
                                              child: Text(
                                                item['label'] ?? '',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopicItem(
    String topicNumber,
    String topicTitle,
    IconData icon,
    bool isActive,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color:
            isActive
                ? const Color(0xFF0D47A1).withValues(alpha: 0.1)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border:
            isActive
                ? Border.all(color: const Color(0xFF0D47A1), width: 2)
                : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.grey.shade600,
            size: 20,
          ),
        ),
        title: Text(
          topicNumber,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade600,
          ),
        ),
        subtitle: Text(
          topicTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? Colors.black87 : Colors.grey.shade700,
          ),
        ),
        onTap: () {
          // Handle topic selection
          debugPrint('Selected: $topicTitle');
        },
      ),
    );
  }
}
