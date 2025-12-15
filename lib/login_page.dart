import 'package:flutter/material.dart';
import 'widgets/app_header.dart';
import 'learn_page.dart';
import 'student_dashboard.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String activeMenu = "Log in";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String selectedRole = ""; // No default role selection
  bool showLoginForm = false; // Track if login form should be shown
  bool _isStudentHovered = false;
  bool _isTeacherHovered = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Check if widget is still mounted before navigation
      if (!mounted) return;

      // Navigate to dashboard on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StudentDashboard()),
      );
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
          // Header
          AppHeader(
            activeMenu: activeMenu,
            onMenuChanged: (menu) {
              setState(() {
                activeMenu = menu;
              });
            },
            parentContext: context,
          ),
          // Main Content
          Column(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 600, // Fixed height for consistent container size
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    padding: const EdgeInsets.all(30),
                    constraints: const BoxConstraints(maxWidth: 500),
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Fixed height layout: switch between role selection and login form
                        SizedBox(
                          height: 500,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child:
                                showLoginForm
                                    ? SizedBox(
                                      key: const ValueKey('loginForm'),
                                      width: double.infinity,
                                      child: _buildLoginForm(),
                                    )
                                    : SizedBox(
                                      key: const ValueKey('roleSelection'),
                                      width: double.infinity,
                                      child: _buildRoleSelection(),
                                    ),
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

  Widget _buildRoleSelection() {
    return SingleChildScrollView(
      child: Column(
        key: const ValueKey('roleSelection'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Welcome Text
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Sign in to continue your Jawi learning journey',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ), //space between welcome text and role selection
          // Role Selection Title
          const Text(
            'Pick your role',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Role Cards in a Row so they lay out side-by-side where space allows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Student Role
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isStudentHovered = true),
                onExit: (_) => setState(() => _isStudentHovered = false),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = "Student";
                      showLoginForm = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          _isStudentHovered
                              ? const Color(0xFFF3F8FF)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            _isStudentHovered
                                ? const Color(0xFF0D47A1)
                                : Colors.grey.shade300,
                        width: _isStudentHovered ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              _isStudentHovered
                                  ? Colors.black.withOpacity(0.15)
                                  : Colors.black12,
                          blurRadius: _isStudentHovered ? 8 : 4,
                          offset: Offset(0, _isStudentHovered ? 4 : 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/user_student.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "I'm a student",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                _isStudentHovered
                                    ? const Color(0xFF0D47A1)
                                    : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Teacher Role
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isTeacherHovered = true),
                onExit: (_) => setState(() => _isTeacherHovered = false),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = "Teacher";
                      showLoginForm = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 140,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          _isTeacherHovered
                              ? const Color(0xFFF3F8FF)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            _isTeacherHovered
                                ? const Color(0xFF0D47A1)
                                : Colors.grey.shade300,
                        width: _isTeacherHovered ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              _isTeacherHovered
                                  ? Colors.black.withOpacity(0.15)
                                  : Colors.black12,
                          blurRadius: _isTeacherHovered ? 8 : 4,
                          offset: Offset(0, _isTeacherHovered ? 4 : 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/user_teacher.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "I'm a teacher",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                _isTeacherHovered
                                    ? const Color(0xFF0D47A1)
                                    : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Continue as Guest
          TextButton(
            onPressed: () {
              // Navigate directly to learn page as guest
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LearnPage()),
              );
            },
            child: const Text(
              'Continue as Guest',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Back Button
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    showLoginForm = false;
                    selectedRole = "";
                  });
                },
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
                label: const Text(
                  'Back to role selection',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),

          // Expand and allow scrolling for smaller screens
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Selected Role Display
                    Text(
                      'Sign in as $selectedRole',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    // Password Field
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Forgot password feature coming soon!',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF0D47A1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF0D47A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !_isPasswordVisible,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
