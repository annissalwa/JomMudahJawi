import 'package:flutter/material.dart';
import 'widgets/app_header.dart';
import 'login_page.dart';
import 'student_dashboard.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String activeMenu = "Sign up";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  String selectedRole = ""; // No default role selection
  bool showSignupForm = false; // Track if signup form should be shown
  bool _isStudentHovered = false;
  bool _isTeacherHovered = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate signup process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Check if widget is still mounted before navigation
      if (!mounted) return;

      // Navigate to dashboard on successful signup
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
      resizeToAvoidBottomInset: true, // Add this to handle keyboard
      body: SafeArea(
        // Wrap in SafeArea for better mobile experience
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/jawi_bg1.jpg',
                fit: BoxFit.cover,
              ),
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
                            color: Colors.black26.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Fixed height layout: switch between role selection and signup form
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
                                  showSignupForm
                                      ? SizedBox(
                                        key: const ValueKey('signupForm'),
                                        width: double.infinity,
                                        child: _buildSignupForm(),
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
            'Welcome!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Create your account to start learning Jawi',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),

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
              _buildRoleCard("Student", true),
              _buildRoleCard("Teacher", false),
            ],
          ),

          const SizedBox(height: 30),

          // Already have account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
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
                    showSignupForm = false;
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
          const SizedBox(height: 20),

          // Expand and allow scrolling for smaller screens
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Selected Role Display
                    Text(
                      'Sign up as $selectedRole',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Name Field
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

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

                    // Phone Number Field (Only for Teachers)
                    if (selectedRole == "Teacher")
                      Column(
                        children: [
                          _buildTextField(
                            controller: _phoneController,
                            hintText: 'Enter your phone number',
                            prefixIcon: Icons.phone_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (!RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(value.replaceAll(RegExp(r'[\s-()]'), ''))) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),

                    // Password Field
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      isPasswordField: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                          return 'Password must contain lowercase letters';
                        }
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                          return 'Password must contain uppercase letters';
                        }
                        if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                          return 'Password must contain numbers';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    // Confirm Password Field
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm your password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      isConfirmPasswordField: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Signup Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignup,
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
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign In',
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
    bool isPasswordField = false,
    bool isConfirmPasswordField = false,
    String? Function(String?)? validator,
  }) {
    bool isVisible =
        isPasswordField
            ? _isPasswordVisible
            : (isConfirmPasswordField ? _isConfirmPasswordVisible : false);

    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isVisible,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isPasswordField) {
                        _isPasswordVisible = !_isPasswordVisible;
                      } else if (isConfirmPasswordField) {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      }
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

  Widget _buildRoleCard(String role, bool isStudent) {
    bool isHovered = isStudent ? _isStudentHovered : _isTeacherHovered;
    String imagePath =
        isStudent
            ? 'assets/images/user_student.png'
            : 'assets/images/user_teacher.png';
    String text = isStudent ? "I'm a student" : "I'm a teacher";

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter:
          (_) => setState(() {
            if (isStudent) {
              _isStudentHovered = true;
            } else {
              _isTeacherHovered = true;
            }
          }),
      onExit:
          (_) => setState(() {
            if (isStudent) {
              _isStudentHovered = false;
            } else {
              _isTeacherHovered = false;
            }
          }),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
            showSignupForm = true;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 140,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFFF3F8FF) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered ? const Color(0xFF0D47A1) : Colors.grey.shade300,
              width: isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isHovered
                        ? Colors.black.withValues(alpha: 0.15)
                        : Colors.black12,
                blurRadius: isHovered ? 8 : 4,
                offset: Offset(0, isHovered ? 4 : 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(imagePath, width: 100, height: 100),
              const SizedBox(height: 12),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isHovered ? const Color(0xFF0D47A1) : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
