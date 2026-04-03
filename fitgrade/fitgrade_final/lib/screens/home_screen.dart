import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'check_screen.dart';
import 'outfit_detail_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final VoidCallback? onStyleTipsTap;
  final VoidCallback? onViewAllTap;

  const HomeScreen({
    super.key,
    required this.userName,
    this.onStyleTipsTap,
    this.onViewAllTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Hey, ${widget.userName} ',
                  style: GoogleFonts.dmSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary),
                  children: const [
                    TextSpan(text: '👋', style: TextStyle(fontSize: 26)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text('Ready to check your fit?',
                  style: GoogleFonts.dmSans(
                      fontSize: 16, color: AppColors.textSecondary)),
              const SizedBox(height: 28),

              PrimaryButton(
                label: 'Upload Outfit',
                icon: Icons.camera_alt_outlined,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CheckScreen())),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                label: 'Get Style Tips',
                icon: Icons.auto_awesome_outlined,
                onTap: widget.onStyleTipsTap,
              ),
              const SizedBox(height: 36),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Fits',
                      style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  GestureDetector(
                    onTap: widget.onViewAllTap,
                    child: Text('View All',
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _FitItem(score: 8.2, label: 'Casual', time: 'Today', up: true),
              const SizedBox(height: 12),
              _FitItem(score: 7.5, label: 'Work', time: 'Yesterday', up: false),
              const SizedBox(height: 12),
              _FitItem(score: 9.1, label: 'Date Night', time: 'Feb 7', up: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _FitItem extends StatelessWidget {
  final double score;
  final String label;
  final String time;
  final bool up;

  const _FitItem({
    required this.score,
    required this.label,
    required this.time,
    required this.up,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OutfitDetailScreen(
            score: score,
            label: label,
            date: time,
            up: up,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.camera_alt_outlined,
                color: Color(0xFFB0B8C1), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScoreBadge(score: score),
                const SizedBox(height: 2),
                Text(label,
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.access_time_outlined,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(time,
                  style: GoogleFonts.dmSans(
                      fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
