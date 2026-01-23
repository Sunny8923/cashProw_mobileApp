import 'package:cash_prow/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _obscurePassword = true;
  bool _loginWithOtp = false;

  final TextEditingController _emailMobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _emailMobileController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    // ✅ Listen for error / success
    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }

      if (next.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 70),

              // 🏢 Company Logo (CENTER)
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/company_logo.jpeg',
                          height: 55,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 📧 Email / Mobile
              _inputField(
                controller: _emailMobileController,
                hint: 'Email or Mobile number',
                icon: Icons.person_outline,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // 🔑 Password OR OTP
              if (!_loginWithOtp)
                _passwordField()
              else
                _inputField(
                  controller: _otpController,
                  hint: 'Enter OTP',
                  icon: Icons.lock_outline,
                  keyboardType: TextInputType.number,
                ),

              const SizedBox(height: 6),
              const SizedBox(height: 10),

              // 🔁 Toggle login mode
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: authState.isLoading
                      ? null
                      : () {
                          setState(() {
                            _loginWithOtp = !_loginWithOtp;
                          });
                        },
                  child: Text(
                    _loginWithOtp ? 'Login with Password' : 'Login with OTP',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🚀 Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () async {
                          final emailOrMobile = _emailMobileController.text
                              .trim();

                          if (emailOrMobile.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Enter email/mobile"),
                              ),
                            );
                            return;
                          }

                          if (_loginWithOtp) {
                            // ✅ OTP logic not implemented yet
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP login not implemented yet"),
                              ),
                            );
                            return;
                          }

                          final password = _passwordController.text.trim();
                          if (password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter password")),
                            );
                            return;
                          }

                          // ✅ Call API via Riverpod
                          await ref
                              .read(authControllerProvider.notifier)
                              .login(email: emailOrMobile, password: password);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5B86E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          _loginWithOtp ? 'Send OTP' : 'Login',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔒 Forgot Password
              if (!_loginWithOtp)
                Center(
                  child: TextButton(
                    onPressed: authState.isLoading ? null : () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 📦 Normal Input
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // 👁 Password Field
  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        hintText: 'Password',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }
}
