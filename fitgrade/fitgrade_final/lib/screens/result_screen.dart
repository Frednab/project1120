import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'check_screen.dart';
import 'analyzing_screen.dart';
import 'color_analysis_screen.dart';

class ResultScreen extends StatefulWidget {
  final AnalyzingMode mode;
  const ResultScreen({super.key, this.mode = AnalyzingMode.photo});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _theme = ThemeController();

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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back
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
                    const SizedBox(height: 20),

                    // ── Score Card ─────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1A1A2E), Color(0xFF2D3561)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Text('YOUR FITGRADE SCORE',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white60,
                                  letterSpacing: 1.2)),
                          const SizedBox(height: 12),
                          Text('8.2',
                              style: GoogleFonts.dmSans(
                                  fontSize: 72,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.card,
                                  height: 1)),
                          Text('/10',
                              style: GoogleFonts.dmSans(
                                  fontSize: 22,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              widget.mode == AnalyzingMode.occasion
                                  ? "You're giving exactly the right energy for a date night. The navy tones read confident without trying too hard — she'll notice."
                                  : "This outfit works because it's clean, intentional, and fits the moment. The color palette is cohesive and the silhouette is flattering.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.85),
                                  height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Color Coordination Card ────────────────────────────
                    _ColorCoordinationCard(context: context),
                    const SizedBox(height: 16),

                    // ── What Works ─────────────────────────────────────────
                    _FeedbackCard(
                      title: 'What Works',
                      color: AppColors.greenBg,
                      iconColor: AppColors.green,
                      icon: Icons.check_circle,
                      dotColor: AppColors.green,
                      items: const [
                        'Color coordination is excellent — navy and white is a timeless pairing',
                        'The fit sits well on the shoulders which reads confident',
                        'Accessories are minimal and let the outfit speak for itself',
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Improvements ───────────────────────────────────────
                    _FeedbackCard(
                      title: 'One Thing to Fix',
                      color: AppColors.orangeBg,
                      iconColor: AppColors.orange,
                      icon: Icons.lightbulb_outline,
                      dotColor: AppColors.orange,
                      items: const [
                        'The shoes break the clean line — swap to white sneakers or loafers to keep the polish',
                        'Tucking in the shirt would add 20% more structure to the overall look',
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Quick Swaps ────────────────────────────────────────
                    const _QuickSwapsCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ── Bottom Actions ─────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
              decoration: BoxDecoration(
                color: AppColors.card,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, -4))
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Outfit saved to your history',
                                style: GoogleFonts.dmSans(color: Colors.white)),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_outline, size: 18),
                      label: Text('Save',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        side: BorderSide(color: AppColors.divider),
                        foregroundColor: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CheckScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Text('New Check',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Color Coordination Card (inline on result) ───────────────────────────────
class _ColorCoordinationCard extends StatelessWidget {
  final BuildContext context;
  const _ColorCoordinationCard({required this.context});

  @override
  Widget build(BuildContext context) {
    // Detected outfit colors (mock — will come from AI later)
    final detectedPairs = [
      _InlinePair('Top', const Color(0xFF1A237E), 'Navy Blue'),
      _InlinePair('Bottom', const Color(0xFFFFFFFF), 'White'),
      _InlinePair('Shoes', const Color(0xFF4E342E), 'Brown'),
    ];

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.palette_outlined,
                    color: AppColors.accent, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Color Coordination',
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary)),
                    Text('Detected from your outfit',
                        style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
              // Score pill
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.greenBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('9/10',
                    style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Detected color blocks
          Row(
            children: detectedPairs
                .map((p) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: detectedPairs.indexOf(p) <
                                    detectedPairs.length - 1
                                ? 8
                                : 0),
                        child: Column(
                          children: [
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: p.color,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.divider),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          p.color.withOpacity(0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3))
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(p.label,
                                style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textSecondary)),
                            Text(p.colorName,
                                style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary)),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 14),

          // Short verdict
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.greenBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: AppColors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Navy + White is a classic pairing. The brown shoes add warmth but could be swapped for white or black for cleaner coordination.',
                    style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Deep dive button
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ColorAnalysisScreen()),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.colorize_outlined,
                      color: AppColors.accent, size: 16),
                  const SizedBox(width: 8),
                  Text('Full Color Analysis for Your Complexion',
                      style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios,
                      color: AppColors.accent, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InlinePair {
  final String label;
  final Color color;
  final String colorName;
  const _InlinePair(this.label, this.color, this.colorName);
}

// ─── Quick Swaps Card ─────────────────────────────────────────────────────────
class _QuickSwapsCard extends StatelessWidget {
  const _QuickSwapsCard();

  static const _swaps = [
    _Swap('👟', 'Shoes', 'White leather sneakers or tan loafers'),
    _Swap('👔', 'Top', 'Tuck in your shirt for a cleaner silhouette'),
    _Swap('⌚', 'Accessory', 'A simple watch ties the whole look together'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: AppColors.accent, shape: BoxShape.circle),
                child: Icon(Icons.swap_horiz_rounded,
                    color: AppColors.card, size: 18),
              ),
              const SizedBox(width: 12),
              Text('Quick Swaps',
                  style: GoogleFonts.dmSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('3 suggestions',
                    style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Small changes, big difference',
              style: GoogleFonts.dmSans(
                  fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ..._swaps.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                          child: Text(s.emoji,
                              style: const TextStyle(fontSize: 22))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.label,
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary)),
                          const SizedBox(height: 2),
                          Text(s.suggestion,
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _Swap {
  final String emoji;
  final String label;
  final String suggestion;
  const _Swap(this.emoji, this.label, this.suggestion);
}

// ─── Feedback Card ────────────────────────────────────────────────────────────
class _FeedbackCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color iconColor;
  final Color dotColor;
  final IconData icon;
  final List<String> items;

  const _FeedbackCard({
    required this.title,
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.items,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration:
                    BoxDecoration(color: iconColor, shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.card, size: 18),
              ),
              const SizedBox(width: 12),
              Text(title,
                  style: GoogleFonts.dmSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        color: dotColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(item,
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
