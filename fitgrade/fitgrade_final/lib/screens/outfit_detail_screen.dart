import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'color_analysis_screen.dart';

class OutfitDetailScreen extends StatefulWidget {
  final double score;
  final String label;
  final String date;
  final bool up;

  const OutfitDetailScreen({
    super.key,
    required this.score,
    required this.label,
    required this.date,
    required this.up,
  });

  @override
  State<OutfitDetailScreen> createState() => _OutfitDetailScreenState();
}

class _OutfitDetailScreenState extends State<OutfitDetailScreen> {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
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

              // Photo placeholder
              Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF0),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt_outlined,
                        size: 48, color: Color(0xFFB0B8C1)),
                    const SizedBox(height: 10),
                    Text('${widget.label} outfit',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Score card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A1A2E), Color(0xFF2D3561)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('FITGRADE SCORE',
                            style: GoogleFonts.dmSans(
                                fontSize: 11,
                                color: Colors.white54,
                                letterSpacing: 1.1)),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${widget.score}',
                                style: GoogleFonts.dmSans(
                                    fontSize: 52,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.card,
                                    height: 1)),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text('/10',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 18,
                                      color: Colors.white54)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              widget.up
                                  ? Icons.trending_up_rounded
                                  : Icons.trending_down_rounded,
                              color: widget.up
                                  ? AppColors.green
                                  : AppColors.orange,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.up ? 'Above your average' : 'Below your average',
                              style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: widget.up
                                      ? AppColors.green
                                      : AppColors.orange),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(widget.label,
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                        const SizedBox(height: 8),
                        Text(widget.date,
                            style: GoogleFonts.dmSans(
                                fontSize: 12, color: Colors.white54)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // What Worked
              _DetailCard(
                title: 'What Worked',
                color: AppColors.greenBg,
                iconColor: AppColors.green,
                icon: Icons.check_circle,
                dotColor: AppColors.green,
                items: const [
                  'Color coordination was excellent for the occasion',
                  'Fit sat well on the shoulders — read as confident',
                  'Accessories complemented without overpowering',
                ],
              ),
              const SizedBox(height: 14),

              // Could Improve
              _DetailCard(
                title: 'Could Improve',
                color: AppColors.orangeBg,
                iconColor: AppColors.orange,
                icon: Icons.lightbulb_outline,
                dotColor: AppColors.orange,
                items: const [
                  'Shoes broke the clean silhouette slightly',
                  'Tucking in the shirt would have added structure',
                ],
              ),
              const SizedBox(height: 14),

              // Color analysis shortcut
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ColorAnalysisScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.palette_outlined,
                          color: AppColors.accent, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text('View Color Analysis for this outfit',
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.accent)),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: AppColors.accent, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final Color color;
  final Color iconColor;
  final Color dotColor;
  final IconData icon;
  final List<String> items;

  const _DetailCard({
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration:
                    BoxDecoration(color: iconColor, shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.card, size: 16),
              ),
              const SizedBox(width: 10),
              Text(title,
                  style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                          color: dotColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(item,
                          style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              height: 1.5)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
