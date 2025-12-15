import 'package:flutter/material.dart';
import 'widgets/app_header.dart';
import 'main.dart';
import 'learn_page.dart';
import 'login_page.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String activeMenu = "Profile"; // Changed from "Log in" to "Profile"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F6FF),
      body: Stack(
        children: [
          // Background (replace with your image if needed)
          Positioned.fill(
            child: Image.asset('assets/images/jawi_bg1.jpg', fit: BoxFit.cover),
          ),

          Column(
            children: [
              // ---------------------- CONSISTENT HEADER ----------------------
              AppHeader(
                activeMenu: activeMenu,
                showProfile: true, // Show Profile instead of Log in
                onMenuChanged: (menu) {
                  setState(() => activeMenu = menu);
                  if (menu == "Home") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else if (menu == "Learn") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LearnPage()),
                    );
                  } else if (menu == "Log in") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }
                  // Profile menu doesn't need navigation since we're already here
                },
                parentContext: context,
              ),

              // ---------------------- DASHBOARD CONTENT ----------------------
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------------- LEFT SECTION ----------------
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _searchBar(),

                              const SizedBox(height: 20),

                              _dashboardCard(),

                              const SizedBox(height: 30),

                              _sectionTitle("Feature"),

                              const SizedBox(height: 10),

                              _featureRow(),

                              const SizedBox(height: 30),

                              _sectionTitle("Past Exercise"),

                              const SizedBox(height: 10),

                              _pastExerciseCard(),
                            ],
                          ),
                        ),

                        const SizedBox(width: 40),

                        // ---------------- RIGHT SECTION ----------------
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _profileHeader(),

                              const SizedBox(height: 20),

                              _scheduleCard(),

                              const SizedBox(height: 20),

                              _appointmentSection(),

                              const SizedBox(height: 20),

                              _messagesSection(),
                            ],
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

  // -----------------------------------------------------------------
  // WIDGETS
  // -----------------------------------------------------------------

  Widget _searchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search Here",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _dashboardCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xffFFDBDB), Color(0xffFFEAB5)],
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Student's Dashboard",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _smallButton("Get Started"),
                    const SizedBox(width: 12),
                    _smallButton("Learn More", outline: true),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: Image.asset('assets/images/dashboard_people.png')),
        ],
      ),
    );
  }

  Widget _smallButton(String text, {bool outline = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: outline ? Colors.transparent : Colors.white,
        border: outline ? Border.all(color: Colors.white) : null,
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _featureRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _featureCard(Icons.fitness_center, "Exercise"),
        _featureCard(Icons.quiz, "Quizzes"),
        _featureCard(Icons.video_collection, "Class"),
        _featureCard(Icons.gamepad, "Games"),
        _featureCard(Icons.question_answer, "Q n A"),
      ],
    );
  }

  Widget _featureCard(IconData icon, String title) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 45, color: Colors.blue),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _pastExerciseCard() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: const Center(
        child: Text(
          "No Past Exercises Yet",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage("assets/images/profile_girl.png"),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Annis Salwa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("@D2021101828", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _scheduleCard() {
    return Row(
      children: [
        _dateBox("20", "Surgery"),
        const SizedBox(width: 15),
        _dateBox("22", "Therapy"),
      ],
    );
  }

  Widget _dateBox(String date, String label) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          const Text(
            "2024 December",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(label),
        ],
      ),
    );
  }

  Widget _appointmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Appointment"),
        const SizedBox(height: 10),
        _appointmentItem("Lifestyle Counseling", "Dr. Claudia Alves", true),
        const SizedBox(height: 10),
        _appointmentItem("Rehabilitation", "Dr. Claudia Alves", false),
        const SizedBox(height: 10),
        _appointmentItem("Preventive Care", "Dr. Claudia Alves", false),
      ],
    );
  }

  Widget _appointmentItem(String title, String doctor, bool highlight) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: highlight ? Colors.blueAccent : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          const Icon(Icons.medical_information, color: Colors.white),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: highlight ? Colors.white : Colors.black,
                ),
              ),
              Text(
                doctor,
                style: TextStyle(
                  color: highlight ? Colors.white70 : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Message"),
        const SizedBox(height: 10),
        _messageItem("Dr. Alfredo Torres", "1 Minute Ago"),
        const SizedBox(height: 10),
        _messageItem("Dr. Claudia Alves", "5 Minutes Ago"),
      ],
    );
  }

  Widget _messageItem(String name, String time) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          const Icon(Icons.account_circle, size: 40, color: Colors.blue),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
