import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/app_header.dart';
import 'main.dart';
import 'login_page.dart';

// Conditional imports for platform-specific features
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:html' as html if (dart.library.html) 'dart:html';
import 'dart:ui_web' as ui_web if (dart.library.html) 'dart:ui_web';

class QuizPage extends StatefulWidget {
  final String? quizUrl;

  const QuizPage({super.key, this.quizUrl});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool _isLoading = false;
  bool _showQuiz = false;
  WebViewController? _webViewController;
  String _iframeId = 'quiz-iframe';

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      // Initialize WebView controller for mobile platforms
      _webViewController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (String url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            );
    }
  }

  void _startQuiz() {
    final String url =
        widget.quizUrl ??
        'https://quizizz.com/join/quiz/5ee8cd49b647c6001cc9f631/start';

    setState(() {
      _isLoading = true;
      _showQuiz = true;
    });

    if (kIsWeb) {
      _setupWebIframe(url);
    } else {
      _webViewController?.loadRequest(Uri.parse(url));
    }
  }

  void _setupWebIframe(String url) {
    // Create iframe element for web
    final iframe =
        html.IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..onLoad.listen((event) {
            setState(() {
              _isLoading = false;
            });
          });

    // Register the iframe as a platform view
    ui_web.platformViewRegistry.registerViewFactory(
      _iframeId,
      (int viewId) => iframe,
    );
  }

  Widget _buildQuizContent() {
    if (!_showQuiz) {
      return _buildWelcomeScreen();
    }

    if (kIsWeb) {
      return Stack(
        children: [
          HtmlElementView(viewType: _iframeId),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D47A1)),
              ),
            ),
        ],
      );
    } else {
      // Mobile WebView
      return Stack(
        children: [
          WebViewWidget(controller: _webViewController!),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D47A1)),
              ),
            ),
        ],
      );
    }
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Quiz Icon and Title
          Icon(Icons.quiz, size: 100, color: const Color(0xFF0D47A1)),
          const SizedBox(height: 30),
          const Text(
            'Jawi Quiz - Test Your Knowledge!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Ready to start your Jawi quiz?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),

          // Start Quiz Button
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _startQuiz,
            icon:
                _isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : const Icon(Icons.play_arrow),
            label: Text(_isLoading ? 'Loading...' : 'Start Quiz'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 3,
            ),
          ),

          const SizedBox(height: 30),

          // Back Button
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Learning'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F6FF),
      body: Stack(
        children: [
          // Background Image (matching other pages)
          Positioned.fill(
            child: Image.asset('assets/images/jawi_bg1.jpg', fit: BoxFit.cover),
          ),

          Column(
            children: [
              // Header
              AppHeader(
                activeMenu: "Quizzes",
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

              // Main Content (matching learn page structure)
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 40,
                    ),
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header with Back Button (when quiz is shown)
                        if (_showQuiz)
                          Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _showQuiz = false;
                                      _isLoading = false;
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_back),
                                  label: const Text('Back to Quiz Menu'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[600],
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'Jawi Interactive Quiz',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D47A1),
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(
                                  width: 120,
                                ), // Balance the layout
                              ],
                            ),
                          ),

                        // Quiz Content
                        Expanded(child: _buildQuizContent()),
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
