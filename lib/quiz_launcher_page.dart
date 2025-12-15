import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/app_header.dart';
import 'main.dart';
import 'login_page.dart';

class QuizLauncherPage extends StatelessWidget {
  const QuizLauncherPage({super.key});

  // Quiz URLs - Replace with your actual quiz links
  static final List<Map<String, String>> quizzes = [
    {
      'title': 'Jawi Basics Quiz',
      'description': 'Test your knowledge of basic Jawi letters',
      'url': 'https://quizizz.com/join/quiz/QUIZ_ID_1/start',
      'difficulty': 'Beginner',
    },
    {
      'title': 'Jawi Advanced Quiz',
      'description': 'Challenge yourself with advanced Jawi concepts',
      'url': 'https://quizizz.com/join/quiz/QUIZ_ID_2/start',
      'difficulty': 'Advanced',
    },
    {
      'title': 'Jawi Word Formation',
      'description': 'Learn how to form words in Jawi script',
      'url': 'https://quizizz.com/join/quiz/QUIZ_ID_3/start',
      'difficulty': 'Intermediate',
    },
  ];

  Future<void> _launchQuiz(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in browser/app
      );
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F6FF),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/jawi_bg1.jpg', fit: BoxFit.cover),
          ),

          Column(
            children: [
              // Header
              AppHeader(
                activeMenu: "Quiz",
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

              // Title
              Container(
                padding: const EdgeInsets.all(30),
                child: const Text(
                  'Jawi Quizzes',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 10,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Quiz List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = quizzes[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
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
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(20),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D47A1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.quiz,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          quiz['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              quiz['description']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(quiz['difficulty']!),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                quiz['difficulty']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _launchQuiz(quiz['url']!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Start Quiz'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
