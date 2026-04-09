import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'signup_screen.dart';
import '../theme.dart';
import '../theme_controller.dart';

class _Slide {
  final String title;
  final String subtitle;
  final String imageUrl;
  const _Slide(this.title, this.subtitle, this.imageUrl);
}

const _slides = [
  _Slide(
    'Struggling with outfits?',
    'Upload your fit and get instant feedback.',
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=700&q=80',
  ),
  _Slide(
    'Dress with confidence',
    'We analyze colors, fit, and occasion.',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=700&q=80',
  ),
  _Slide(
    'Ready for every moment',
    'Dates. Work. Parties. Everyday.',
    'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=700&q=80',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _theme = ThemeController();

  final _ctrl = PageController();
  int _page = 0;

  void _next() {
    if (_page < _slides.length - 1) {
      _ctrl.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else {
      _goToSignup();
    }
  }

  void _goToSignup() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupScreen()),
      );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
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
            const SizedBox(height: 20),
            SmoothPageIndicator(
              controller: _ctrl,
              count: _slides.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                expansionFactor: 5,
                spacing: 6,
                dotColor: Colors.grey.shade300,
                activeDotColor: AppColors.primary,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _slides.length,
                itemBuilder: (_, i) => _SlidePage(slide: _slides[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Text(
                        _page == _slides.length - 1 ? 'Start Now' : 'Next',
                        style: GoogleFonts.dmSans(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  if (_page < _slides.length - 1) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _goToSignup,
                      child: Text('Skip',
                          style: GoogleFonts.dmSans(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  final _Slide slide;
  const _SlidePage({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(
                slide.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.grey)),
                ),
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(28)),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
                fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
