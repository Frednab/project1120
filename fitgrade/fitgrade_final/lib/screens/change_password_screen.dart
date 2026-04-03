import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _theme = ThemeController();

  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;
  bool _saving = false;

  bool get _newsMatch =>
      _newCtrl.text.isNotEmpty && _newCtrl.text == _confirmCtrl.text;
  bool get _longEnough => _newCtrl.text.length >= 8;

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_newsMatch || !_longEnough) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password updated successfully!',
            style: GoogleFonts.dmSans(color: Colors.white)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
    Navigator.pop(context);
  }


  @override
  void initState() {
    super.initState();
    _theme.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8)],
                            ),
                            child: const Icon(Icons.arrow_back, size: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Change Password',
                                style: GoogleFonts.dmSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary)),
                            Text('Keep your account secure',
                                style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // Lock icon
                    Center(
                      child: Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.lock_outline,
                            size: 32, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 36),

                    _FieldLabel('Current Password'),
                    const SizedBox(height: 8),
                    _PasswordField(
                      controller: _currentCtrl,
                      hint: 'Enter current password',
                      visible: _showCurrent,
                      onToggle: () =>
                          setState(() => _showCurrent = !_showCurrent),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),

                    _FieldLabel('New Password'),
                    const SizedBox(height: 8),
                    _PasswordField(
                      controller: _newCtrl,
                      hint: 'At least 8 characters',
                      visible: _showNew,
                      onToggle: () => setState(() => _showNew = !_showNew),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 8),

                    // Strength indicator
                    if (_newCtrl.text.isNotEmpty) ...[
                      _StrengthBar(password: _newCtrl.text),
                      const SizedBox(height: 12),
                    ],

                    _FieldLabel('Confirm New Password'),
                    const SizedBox(height: 8),
                    _PasswordField(
                      controller: _confirmCtrl,
                      hint: 'Re-enter new password',
                      visible: _showConfirm,
                      onToggle: () =>
                          setState(() => _showConfirm = !_showConfirm),
                      onChanged: (_) => setState(() {}),
                      isError: _confirmCtrl.text.isNotEmpty && !_newsMatch,
                    ),
                    if (_confirmCtrl.text.isNotEmpty && !_newsMatch) ...[
                      const SizedBox(height: 6),
                      Text('Passwords do not match',
                          style: GoogleFonts.dmSans(
                              fontSize: 12, color: AppColors.orange)),
                    ],
                    if (_newsMatch) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.check_circle,
                              size: 14, color: AppColors.green),
                          const SizedBox(width: 4),
                          Text('Passwords match',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12, color: AppColors.green)),
                        ],
                      ),
                    ],
                    const SizedBox(height: 28),

                    // Rules
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password requirements',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 10),
                          _Rule('At least 8 characters',
                              _newCtrl.text.length >= 8),
                          _Rule('Contains a number',
                              _newCtrl.text.contains(RegExp(r'[0-9]'))),
                          _Rule('Contains uppercase',
                              _newCtrl.text.contains(RegExp(r'[A-Z]'))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
              child: PrimaryButton(
                label: _saving ? 'Updating...' : 'Update Password',
                icon: Icons.lock_outline,
                onTap: (_saving || !_newsMatch || !_longEnough ||
                        _currentCtrl.text.isEmpty)
                    ? null
                    : _save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  final String label;
  final bool met;
  const _Rule(this.label, this.met);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 16,
            color: met ? AppColors.green : AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Text(label,
              style: GoogleFonts.dmSans(
                  fontSize: 13,
                  color: met ? AppColors.green : AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _StrengthBar extends StatelessWidget {
  final String password;
  const _StrengthBar({required this.password});

  int get _strength {
    int s = 0;
    if (password.length >= 8) s++;
    if (password.contains(RegExp(r'[A-Z]'))) s++;
    if (password.contains(RegExp(r'[0-9]'))) s++;
    if (password.contains(RegExp(r'[!@#\$%^&*]'))) s++;
    return s;
  }

  @override
  Widget build(BuildContext context) {
    final s = _strength;
    final color = s <= 1
        ? AppColors.orange
        : s == 2
            ? const Color(0xFFF59E0B)
            : AppColors.green;
    final label = s <= 1 ? 'Weak' : s == 2 ? 'Fair' : 'Strong';

    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(4, (i) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: i < s ? color : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 10),
        Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color)),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool visible;
  final VoidCallback onToggle;
  final ValueChanged<String> onChanged;
  final bool isError;

  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.visible,
    required this.onToggle,
    required this.onChanged,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isError ? AppColors.orange : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: !visible,
        onChanged: onChanged,
        style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.dmSans(
              color: AppColors.textSecondary, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              visible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary));
}
