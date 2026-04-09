import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'analyzing_screen.dart';

// ─── Entry point: choose mode ─────────────────────────────────────────────────
class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06), blurRadius: 8)
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
              ),
              const SizedBox(height: 28),
              Text('Check Your Fit',
                  style: GoogleFonts.dmSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('How would you like to get started?',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, color: AppColors.textSecondary)),
              const SizedBox(height: 36),

              // Mode 1: Got a Date?
              _ModeCard(
                emoji: '💘',
                title: 'Got a Date?',
                subtitle: 'Tell us the occasion and get outfit advice fast',
                gradient: const [Color(0xFF1A1A2E), Color(0xFF3D2B6B)],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OccasionScreen()),
                ),
              ),
              const SizedBox(height: 16),

              // Mode 2: Upload outfit
              _ModeCard(
                emoji: '📸',
                title: 'Upload Your Outfit',
                subtitle: 'Take or choose a photo for an instant score',
                gradient: const [Color(0xFF1A2A5E), Color(0xFF2D4A8A)],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadOutfitScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _ModeCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(subtitle,
                      style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: Colors.white70,
                          height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }
}

// ─── Occasion Flow ────────────────────────────────────────────────────────────
class OccasionScreen extends StatefulWidget {
  const OccasionScreen({super.key});

  @override
  State<OccasionScreen> createState() => _OccasionScreenState();
}

class _OccasionScreenState extends State<OccasionScreen> {
  final _theme = ThemeController();
  String? _selectedOccasion;
  String? _selectedVibe;
  final _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _theme.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _theme.removeListener(() => setState(() {}));
    _detailsController.dispose();
    super.dispose();
  }

  final _occasions = [
    _Occasion('💘', 'Date Night', 'Romantic evening out'),
    _Occasion('☕', 'Coffee Meetup', 'Casual daytime hang'),
    _Occasion('🍽️', 'Dinner', 'Restaurant or event'),
    _Occasion('💼', 'Work / Interview', 'Professional setting'),
    _Occasion('🎉', 'Party', 'Social gathering'),
    _Occasion('🛍️', 'Casual Outing', 'Everyday errand or hangout'),
  ];

  final _vibes = ['Smart Casual', 'Laid Back', 'Formal', 'Streetwear', 'Minimalist'];

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
                    // Header
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 8)
                              ],
                            ),
                            child: const Icon(Icons.arrow_back, size: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Got a Date? 💘',
                                style: GoogleFonts.dmSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary)),
                            Text("Let's find your perfect look",
                                style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Step 1: Occasion
                    _SectionLabel(
                        number: '1', title: "What's the occasion?"),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.4,
                      children: _occasions.map((o) {
                        final selected = _selectedOccasion == o.title;
                        final isDark = ThemeController().isDarkMode;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedOccasion = o.title),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.accent
                                  : (isDark ? const Color(0xFF2C2C4E) : Colors.white),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selected
                                    ? AppColors.accent
                                    : (isDark ? const Color(0xFF5A5A8A) : Colors.grey.shade200),
                                width: isDark ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(o.emoji,
                                    style: const TextStyle(fontSize: 20)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(o.title,
                                      style: GoogleFonts.dmSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: selected
                                              ? Colors.white
                                              : (isDark ? Colors.white : const Color(0xFF1A1A2E)))),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 28),

                    // Step 2: Vibe
                    _SectionLabel(number: '2', title: 'Pick your vibe'),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _vibes.map((v) {
                        final selected = _selectedVibe == v;
                        final isDark = ThemeController().isDarkMode;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedVibe = v),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.accent
                                  : (isDark ? const Color(0xFF2C2C4E) : Colors.white),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? AppColors.accent
                                    : (isDark ? const Color(0xFF5A5A8A) : Colors.grey.shade200),
                                width: isDark ? 1.5 : 1,
                              ),
                            ),
                            child: Text(v,
                                style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: selected
                                        ? Colors.white
                                        : (isDark ? Colors.white : const Color(0xFF1A1A2E)))),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 28),

                    // Step 3: Optional details
                    _SectionLabel(
                        number: '3',
                        title: 'Any details? (optional)',
                        subtitle: 'e.g. "outdoor rooftop bar" or "she likes classy"'),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: TextField(
                        controller: _detailsController,
                        maxLines: 3,
                        style: GoogleFonts.dmSans(
                            fontSize: 15, color: AppColors.textPrimary),
                        decoration: InputDecoration(
                          hintText:
                              'Tell the AI anything that might help...',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColors.textSecondary, fontSize: 14),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // CTA
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
              child: PrimaryButton(
                label: 'Get My Outfit Advice',
                icon: Icons.auto_awesome_outlined,
                onTap: _selectedOccasion == null
                    ? null
                    : () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AnalyzingScreen(
                                  mode: AnalyzingMode.occasion)),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Occasion {
  final String emoji;
  final String title;
  final String subtitle;
  const _Occasion(this.emoji, this.title, this.subtitle);
}

class _SectionLabel extends StatelessWidget {
  final String number;
  final String title;
  final String? subtitle;
  const _SectionLabel(
      {required this.number, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
              color: AppColors.primary, shape: BoxShape.circle),
          child: Center(
            child: Text(number,
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              if (subtitle != null)
                Text(subtitle!,
                    style: GoogleFonts.dmSans(
                        fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Upload Outfit Screen ─────────────────────────────────────────────────────
class UploadOutfitScreen extends StatefulWidget {
  const UploadOutfitScreen({super.key});

  @override
  State<UploadOutfitScreen> createState() => _UploadOutfitScreenState();
}

class _UploadOutfitScreenState extends State<UploadOutfitScreen> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pick(ImageSource source) async {
    try {
      final picked =
          await _picker.pickImage(source: source, imageQuality: 85);
      if (picked != null) {
        setState(() => _image = File(picked.path));
        await Future.delayed(const Duration(milliseconds: 300));
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  const AnalyzingScreen(mode: AnalyzingMode.photo)),
        );
      }
    } catch (_) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const AnalyzingScreen(mode: AnalyzingMode.photo)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back, size: 20),
                ),
              ),
              const SizedBox(height: 28),
              Text('Upload Your Outfit',
                  style: GoogleFonts.dmSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('Take a photo or choose from your gallery',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              Expanded(child: DottedUploadBox(image: _image)),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Take Photo',
                icon: Icons.camera_alt_outlined,
                onTap: () => _pick(ImageSource.camera),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                label: 'Choose from Gallery',
                icon: Icons.image_outlined,
                onTap: () => _pick(ImageSource.gallery),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedUploadBox extends StatelessWidget {
  final File? image;
  const DottedUploadBox({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(image!, fit: BoxFit.cover),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt_outlined,
                      size: 36, color: Color(0xFFB0B8C1)),
                ),
                const SizedBox(height: 20),
                Text('No photo selected',
                    style: GoogleFonts.dmSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                Text('Upload a clear photo of your outfit',
                    style: GoogleFonts.dmSans(
                        fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
    );
  }
}
