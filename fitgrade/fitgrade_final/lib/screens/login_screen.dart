import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
import 'main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _theme = ThemeController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _googleLoading = false;
  bool _hidePassword = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _theme.addListener(() { if (mounted) setState(() {}); });
  }

  void _login() async {
    final email = _email.text.trim();
    final password = _password.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Please enter your email and password');
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      await AuthService.signIn(email: email, password: password);
      if (!mounted) return;
      final name = AuthService.displayName;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => MainShell(userName: name)));
    } catch (e) {
      setState(() { _error = _friendlyError(e.toString()); _loading = false; });
    }
  }

  void _googleLogin() async {
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

  void _forgotPassword() async {
    final email = _email.text.trim();
    if (email.isEmpty) { setState(() => _error = 'Enter your email above first'); return; }
    try {
      await AuthService.resetPassword(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent!')));
    } catch (e) {
      setState(() => _error = _friendlyError(e.toString()));
    }
  }

  String _friendlyError(String e) {
    if (e.contains('Invalid login') || e.contains('invalid_credentials'))
      return 'Incorrect email or password';
    if (e.contains('Email not confirmed')) return 'Please confirm your email first';
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
            children: [
              const SizedBox(height: 60),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back',
                        style: GoogleFonts.dmSans(fontSize: 28,
                            fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    Text('Login to continue to FitGrade',
                        style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textSecondary)),
                    const SizedBox(height: 28),
                    AppTextField(controller: _email, label: 'Email',
                        hint: 'your@email.com', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('Password', style: GoogleFonts.dmSans(fontSize: 15,
                          fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      GestureDetector(
                        onTap: _forgotPassword,
                        child: Text('Forgot?', style: GoogleFonts.dmSans(
                            fontSize: 14, color: AppColors.accent)),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _password, label: '', hint: 'Enter password',
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
                    PrimaryButton(label: 'Login', onTap: _login, loading: _loading),
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
                      Expanded(child: _SocialBtn(label: 'Google', isApple: false, onTap: _googleLogin)),
                      const SizedBox(width: 12),
                      Expanded(child: _SocialBtn(label: 'Apple', isApple: true, onTap: _login)),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SignupScreen())),
                child: RichText(text: TextSpan(
                  text: "Don't have an account? ",
                  style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textSecondary),
                  children: [TextSpan(text: 'Sign Up',
                      style: GoogleFonts.dmSans(fontSize: 15,
                          fontWeight: FontWeight.w700, color: AppColors.textPrimary))],
                )),
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
