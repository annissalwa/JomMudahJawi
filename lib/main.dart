import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/app_header.dart';

void main() {
  runApp(const JomMudahJawiApp());
}

class JomMudahJawiApp extends StatelessWidget {
  const JomMudahJawiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jom Mudah Jawi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Colors.blueAccent),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeMenu = "Home"; // default active tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F4FF),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1.5,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/jawi_bg1.jpg'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 1.5,
                      color: Colors.white.withOpacity(0.1),
                    ),

                    ClipPath(
                      clipper: TopWaveClipper(),
                      child: Container(height: 120, color: Colors.white),
                    ),

                    Container(
                      margin: const EdgeInsets.all(40),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 150,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "JOM\nMUDAH\nJAWI!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lilitaOne(
                                      fontSize: 102,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0D47A1),
                                      height: 0.95,
                                      shadows: const [
                                        Shadow(
                                          offset: Offset(3, 3),
                                          blurRadius: 5,
                                          color: Colors.lightGreenAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "An Interactive Learning Platform for Jawi\n"
                                    "Mastery in Early Education",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(221, 255, 255, 255),
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
                                  ),
                                ],
                              ),
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/tha.png',
                                      height: 150,
                                    ),
                                    Image.asset(
                                      'assets/images/ta.png',
                                      height: 150,
                                    ),
                                    const SizedBox(width: 20),
                                    Image.asset(
                                      'assets/images/ba.png',
                                      height: 150,
                                    ),
                                    const SizedBox(width: 20),
                                    Image.asset(
                                      'assets/images/alif.png',
                                      height: 150,
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),

                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 400),
              ],
            ),
          ),

          AppHeader(
            activeMenu: activeMenu,
            onMenuChanged: (menu) {
              setState(() => activeMenu = menu);
            },
            parentContext: context,
          ),
        ],
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
