import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart';

class LearnPage extends StatelessWidget {
  final AudioPlayer _player = AudioPlayer();

  LearnPage({super.key});

  final List<Map<String, String>> jawiLetters = [
    {'image': 'assets/images/alif.png', 'sound': 'alif.mp3', 'label': 'Alif'},
    {'image': 'assets/images/ba.png', 'sound': 'ba.mp3', 'label': 'Ba'},
    {'image': 'assets/images/ta.png', 'sound': 'ta.mp3', 'label': 'Ta'},
    {'image': 'assets/images/ta-marbutah.png', 'sound': 'ta-marbutah.mp3', 'label': 'Ta Marbutah'},
    {'image': 'assets/images/tha.png', 'sound': 'tha.mp3', 'label': 'Tha'},
    {'image': 'assets/images/jim.png', 'sound': 'jim.mp3', 'label': 'Jim'},
    {'image': 'assets/images/ca.png', 'sound': 'ca.mp3', 'label': 'Ca'},
    {'image': 'assets/images/ha.png', 'sound': 'ha.mp3', 'label': 'Ha'},
    {'image': 'assets/images/kha.png', 'sound': 'kha.mp3', 'label': 'Kha'},
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
    {'image': 'assets/images/ghain.png', 'sound': 'ghain.mp3', 'label': 'Ghain'},
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
    {'image': 'assets/images/ha-bulat.png', 'sound': 'ha-bulat.mp3', 'label': 'Ha'},
    {'image': 'assets/images/lam-alif.png', 'sound': 'lam-alif.mp3', 'label': 'Lam Alif'},
    {'image': 'assets/images/hamzah.png', 'sound': 'hamzah.mp3', 'label': 'Hamzah'},
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
              Container(
                height: 80,
                color: Colors.white.withOpacity(0.95),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.language, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          "JOM MUDAH JAWI",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        NavItem(
                          title: "Home",
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                        ),
                        NavItem(title: "Learn", active: true, onTap: () {}),
                        NavItem(
                          title: "Quizzes",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Quizzes clicked")),
                            );
                          },
                        ),
                        NavItem(
                          title: "Games",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Games clicked")),
                            );
                          },
                        ),
                        NavItem(
                          title: "Log in",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Log in clicked")),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 80),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Tap on the letter to hear the correct pronunciation.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(221, 255, 255, 255),
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 15,
                                color: Color.fromARGB(255, 31, 31, 31),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        Directionality(
                          textDirection:
                              TextDirection
                                  .rtl, // Makes grid fill from right → left
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
                                  if (soundFile.isNotEmpty) _playSound(soundFile);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),

                                      // 👇 TEXT UNDER IMAGE
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
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
        ],
      ),
    );
  }
}
