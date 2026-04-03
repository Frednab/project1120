import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';

class EditProfileScreen extends StatefulWidget {
  final String userName;
  final String email;
  const EditProfileScreen({super.key, required this.userName, required this.email});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _theme = ThemeController();

  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _bioCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _theme.addListener(() => setState(() {}));
    _nameCtrl = TextEditingController(text: widget.userName);
    _emailCtrl = TextEditingController(text: widget.email);
    _bioCtrl = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated!',
            style: GoogleFonts.dmSans(color: Colors.white)),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
    Navigator.pop(context, _nameCtrl.text.trim());
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
                        Text('Edit Profile',
                            style: GoogleFonts.dmSans(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Avatar
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 90, height: 90,
                            decoration: BoxDecoration(
                                color: AppColors.primary, shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                widget.userName.isNotEmpty
                                    ? widget.userName[0].toUpperCase()
                                    : 'F',
                                style: GoogleFonts.dmSans(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.camera_alt_outlined,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    _FieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    _InputField(controller: _nameCtrl, hint: 'Your name'),
                    const SizedBox(height: 20),

                    _FieldLabel('Email Address'),
                    const SizedBox(height: 8),
                    _InputField(
                        controller: _emailCtrl,
                        hint: 'your@email.com',
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 20),

                    _FieldLabel('Bio (optional)'),
                    const SizedBox(height: 8),
                    _InputField(
                        controller: _bioCtrl,
                        hint: 'A little about your style...',
                        maxLines: 3),
                    const SizedBox(height: 28),

                    // Style preferences section
                    Text('Style Preferences',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    _StylePrefsRow(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
              child: PrimaryButton(
                label: _saving ? 'Saving...' : 'Save Changes',
                icon: Icons.check_outlined,
                onTap: _saving ? null : _save,
              ),
            ),
          ],
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

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.dmSans(
              color: AppColors.textSecondary, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class _StylePrefsRow extends StatefulWidget {
  @override
  State<_StylePrefsRow> createState() => _StylePrefsRowState();
}

class _StylePrefsRowState extends State<_StylePrefsRow> {
  final _prefs = ['Casual', 'Formal', 'Streetwear', 'Business', 'Minimalist', 'Date Night'];
  final _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _prefs.map((p) {
        final on = _selected.contains(p);
        return GestureDetector(
          onTap: () => setState(() => on ? _selected.remove(p) : _selected.add(p)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: on ? AppColors.accent : AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: on ? AppColors.accent : AppColors.divider, width: 1.5),
            ),
            child: Text(p,
                style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: on ? Colors.white : AppColors.textPrimary)),
          ),
        );
      }).toList(),
    );
  }
}
