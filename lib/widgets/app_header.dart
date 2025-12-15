import 'package:flutter/material.dart';
import 'package:jommudahjawi_test/nav_item.dart';
import 'package:jommudahjawi_test/main.dart';
import 'package:jommudahjawi_test/learn_page.dart';
import 'package:jommudahjawi_test/login_page.dart';
import 'package:jommudahjawi_test/quiz_page.dart';

class AppHeader extends StatelessWidget {
  final String activeMenu;
  final Function(String) onMenuChanged;
  final BuildContext parentContext;
  final bool showProfile; // New parameter to show Profile instead of Log in

  const AppHeader({
    super.key,
    required this.activeMenu,
    required this.onMenuChanged,
    required this.parentContext,
    this.showProfile = false, // Default to false (shows Log in)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: Colors.blue.shade100, width: 1),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Section
          Row(
            children: const [
              Icon(Icons.language, color: Colors.blue, size: 28),
              SizedBox(width: 8),
              Text(
                "JOM MUDAH JAWI",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          // Navigation Items
          Row(
            children: [
              NavItem(
                title: "Home",
                active: activeMenu == "Home",
                onTap: () {
                  onMenuChanged("Home");
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              NavItem(
                title: "Learn",
                active: activeMenu == "Learn",
                onTap: () {
                  onMenuChanged("Learn");
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(builder: (context) => LearnPage()),
                  );
                },
              ),
              NavItem(
                title: "Quizzes",
                active: activeMenu == "Quizzes",
                onTap: () {
                  onMenuChanged("Quizzes");
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
              ),
              NavItem(
                title: "Games",
                active: activeMenu == "Games",
                onTap: () {
                  onMenuChanged("Games");
                },
              ),
              NavItem(
                title: showProfile ? "Profile" : "Log in",
                active:
                    activeMenu == "Log in" ||
                    activeMenu == "Profile" ||
                    (activeMenu == "Log in" && showProfile),
                onTap: () {
                  if (showProfile) {
                    onMenuChanged("Profile");
                  } else {
                    onMenuChanged("Log in");
                    Navigator.push(
                      parentContext,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
