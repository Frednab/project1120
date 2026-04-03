import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'color_analysis_screen.dart';

class _Tip {
  final String title;
  final String subtitle;
  final IconData icon;
  final String badge;
  final String detail;

  const _Tip(this.title, this.subtitle, this.icon, this.badge, this.detail);
}

const _tips = [
  _Tip('Color Coordination', 'Match complementary colors for a cohesive look',
      Icons.palette_outlined, 'Popular',
      'Color coordination is about choosing colors that work together harmoniously. Stick to 2–3 colors max per outfit. Use the 60-30-10 rule: 60% dominant color (trousers/jeans), 30% secondary (shirt/top), 10% accent (shoes/accessories).'),
  _Tip('Fit & Proportion', 'Well-fitted clothes make all the difference',
      Icons.checkroom_outlined, 'Essential',
      'No matter how expensive your clothes are, poor fit kills the look. Shoulders should sit at your shoulder bone, not hang off. Trousers should break just at the top of your shoes. A tailor can fix 80% of fit issues cheaply.'),
  _Tip('Seasonal Trends', 'Stay updated with the latest fashion trends',
      Icons.trending_up_outlined, 'New',
      'You don\'t need to follow every trend — just be aware of them. Pick 1–2 trending pieces per season and build them into your existing wardrobe. Trends come and go; fit and coordination are timeless.'),
  _Tip('Accessorize Wisely', 'The right accessories elevate any outfit',
      Icons.auto_awesome_outlined, 'Pro Tip',
      'Accessories do the heavy lifting in a simple outfit. A clean watch, a minimal chain, or the right belt can transform a basic look. Rule of thumb: less is more. Pick one statement piece and keep everything else clean.'),
  _Tip('Layering Basics', 'Master the art of layering for any season',
      Icons.layers_outlined, 'Popular',
      'Layering adds depth and dimension to your outfit. Start with a fitted base layer, add a mid layer (shirt or sweater), and finish with an outer layer (jacket or coat). Ensure each layer is slightly longer than the one inside it.'),
  _Tip('Dress for Your Body', 'Wear styles that flatter your unique shape',
      Icons.person_outline, 'Essential',
      'Fashion rules exist to be bent — but knowing your body type helps. Slim fits work great for lean builds. Relaxed fits balance broader frames. Tapered trousers work for almost everyone. The goal is proportion, not restriction.'),
];

const _categories = ['All', 'Casual', 'Formal', 'Business', 'Date Night'];

// Tips per category — maps category index to which tip indices to show
const _categoryTips = {
  0: [0, 1, 2, 3, 4, 5],     // All
  1: [0, 1, 3, 4],            // Casual
  2: [0, 1, 3, 5],            // Formal
  3: [0, 1, 3, 5],            // Business
  4: [0, 3, 2],               // Date Night
};

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  final _theme = ThemeController();

  int _catIndex = 0;


  @override
  void initState() {
    super.initState();
    _theme.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _theme.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Style Tips',
                  style: GoogleFonts.dmSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 6),
              Text('Expert advice to level up your fashion game',
                  style: GoogleFonts.dmSans(
                      fontSize: 15, color: AppColors.textSecondary)),
              const SizedBox(height: 24),

              // Category chips
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final active = i == _catIndex;
                    return GestureDetector(
                      onTap: () => setState(() => _catIndex = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? AppColors.accent : AppColors.card,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: active ? AppColors.accent : AppColors.divider,
                            width: 1.5,
                          ),
                        ),
                        child: Text(_categories[i],
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: active
                                    ? Colors.white
                                    : AppColors.textPrimary)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 110),
                  children: [
                    // Color Analysis featured card (always visible)
                    _ColorAnalysisFeatureCard(),
                    const SizedBox(height: 12),
                    ...(_categoryTips[_catIndex] ?? [0,1,2,3,4,5]).map((i) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _TipCard(
                          tip: _tips[i],
                          onTap: () {
                            if (_tips[i].title == 'Color Coordination') {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => const ColorAnalysisScreen()));
                            } else {
                              _showTipDetail(context, _tips[i]);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTipDetail(BuildContext context, _Tip tip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TipDetailSheet(tip: tip),
    );
  }
}

class _ColorAnalysisFeatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ColorAnalysisScreen())),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF3D2B6B)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: AppColors.textPrimary.withOpacity(0.25),
                blurRadius: 16,
                offset: const Offset(0, 6))
          ],
        ),
        child: Row(
          children: [
            const Text('🎨', style: TextStyle(fontSize: 40)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Color Analysis',
                      style: GoogleFonts.dmSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('Find your best colors by complexion + outfit pairings',
                      style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: Colors.white70,
                          height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white54, size: 14),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final _Tip tip;
  final VoidCallback onTap;
  const _TipCard({super.key, required this.tip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(tip.icon, color: AppColors.card, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(tip.title,
                          style: GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(tip.badge,
                          style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(tip.subtitle,
                    style: GoogleFonts.dmSans(
                        fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios,
              size: 14, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _TipDetailSheet extends StatelessWidget {
  final _Tip tip;
  const _TipDetailSheet({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(tip.icon, color: AppColors.card, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tip.title,
                        style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary)),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(tip.badge,
                          style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(tip.detail,
              style: GoogleFonts.dmSans(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  height: 1.65)),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text('Got it',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
