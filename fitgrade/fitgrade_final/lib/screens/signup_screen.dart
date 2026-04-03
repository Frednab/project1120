import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'main_shell.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _theme = ThemeController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _googleLoading = false;
  bool _hidePassword = true;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _theme.addListener(() { if (mounted) setState(() {}); });
  }

  void _signUp() async {
    final name = _name.text.trim();
    final email = _email.text.trim();
    final password = _password.text.trim();
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Please fill in all fields'); return;
    }
    if (password.length < 6) {
      setState(() => _error = 'Password must be at least 6 characters'); return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      await AuthService.signUp(name: name, email: email, password: password);
      if (!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => MainShell(userName: name)));
    } catch (e) {
      setState(() { _error = _friendlyError(e.toString()); _loading = false; });
    }
  }

  void _googleSignUp() async {
    setState(() { _googleLoading = true; _error = null; });
    try {
      final success = await AuthService.signInWithGoogle();
      if (!success) { setState(() => _googleLoading = false); return; }
      if (!mounted) return;
      final name = AuthService.displayName;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => MainShell(userName: name)));
    } catch (e) {
      setState(() { _error = _friendlyError(e.toString()); _googleLoading = false; });
    }
  }

  String _friendlyError(String e) {
    if (e.contains('already registered') || e.contains('already been registered'))
      return 'An account with this email already exists';
    if (e.contains('invalid')) return 'Invalid email address';
    if (e.contains('network')) return 'No internet connection';
    return 'Something went wrong. Try again';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('Create Account', style: GoogleFonts.dmSans(fontSize: 34,
                  fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              const SizedBox(height: 6),
              Text('Join FitGrade to elevate your style',
                  style: GoogleFonts.dmSans(fontSize: 16, color: AppColors.textSecondary)),
              const SizedBox(height: 36),
              AppCard(
                child: Column(children: [
                  AppTextField(controller: _name, label: 'Name', hint: 'Your name'),
                  const SizedBox(height: 20),
                  AppTextField(controller: _email, label: 'Email',
                      hint: 'your@email.com', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _password, label: 'Password', hint: 'Min 6 characters',
                    obscure: _hidePassword,
                    suffix: IconButton(
                      icon: Icon(_hidePassword ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined, color: AppColors.textSecondary),
                      onPressed: () => setState(() => _hidePassword = !_hidePassword),
                    ),
                  ),
                  const SizedBox(height: 28),
                  if (_error != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.shade200)),
                      child: Text(_error!, style: GoogleFonts.dmSans(
                          fontSize: 13, color: Colors.red.shade700)),
                    ),
                    const SizedBox(height: 16),
                  ],
                  PrimaryButton(label: 'Sign Up', onTap: _signUp, loading: _loading),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(child: Divider(color: AppColors.divider)),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text('Or continue with', style: GoogleFonts.dmSans(
                            fontSize: 13, color: AppColors.textSecondary))),
                    Expanded(child: Divider(color: AppColors.divider)),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(child: _SocialBtn(label: 'Google', isApple: false, onTap: _googleSignUp)),
                    const SizedBox(width: 12),
                    Expanded(child: _SocialBtn(label: 'Apple', isApple: true, onTap: _signUp)),
                  ]),
                ]),
              ),
              const SizedBox(height: 28),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: RichText(text: TextSpan(
                    text: 'Already have an account? ',
                    style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textSecondary),
                    children: [TextSpan(text: 'Login',
                        style: GoogleFonts.dmSans(fontSize: 15,
                            fontWeight: FontWeight.w700, color: AppColors.textPrimary))],
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialBtn extends StatelessWidget {
  final String label;
  final bool isApple;
  final VoidCallback onTap;
  const _SocialBtn({required this.label, required this.isApple, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: AppColors.divider),
        backgroundColor: const Color(0xFFF9F9FA),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(isApple ? Icons.apple : Icons.g_mobiledata,
            size: isApple ? 20 : 24, color: AppColors.textPrimary),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.dmSans(fontSize: 14,
            fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ]),
    );
  }
}
