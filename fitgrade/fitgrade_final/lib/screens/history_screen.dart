import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'outfit_detail_screen.dart';

class _HistoryItem {
  final double score;
  final String label;
  final String date;
  final bool up;
  const _HistoryItem(this.score, this.label, this.date, this.up);
}

final _items = [
  _HistoryItem(8.2, 'Casual', 'Today, 2:30 PM', true),
  _HistoryItem(7.5, 'Work', 'Yesterday, 9:45 AM', false),
  _HistoryItem(9.1, 'Date Night', 'Feb 7, 6:00 PM', true),
  _HistoryItem(6.8, 'Casual', 'Feb 5, 11:00 AM', false),
  _HistoryItem(8.9, 'Formal', 'Feb 3, 7:30 PM', true),
];

const _filters = ['All Time', 'This Week', 'This Month'];

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _theme = ThemeController();

  int _filter = 0;


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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text('History',
                      style: GoogleFonts.dmSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Track your style journey',
                      style: GoogleFonts.dmSans(
                          fontSize: 15, color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _StatCard(value: '24', label: 'Total\nChecks')),
                      const SizedBox(width: 12),
                      Expanded(child: _StatCard(value: '8.1', label: 'Avg\nScore')),
                      const SizedBox(width: 12),
                      Expanded(child: _StatCard(value: '9.5', label: 'Best\nScore')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _StyleInsightsCard(),
                  const SizedBox(height: 20),
                  Row(
                    children: _filters.asMap().entries.map((e) {
                      final active = e.key == _filter;
                      return Padding(
                        padding: EdgeInsets.only(
                            right: e.key < _filters.length - 1 ? 8 : 0),
                        child: GestureDetector(
                          onTap: () => setState(() => _filter = e.key),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                              color: active ? AppColors.accent : AppColors.card,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: active ? AppColors.accent : AppColors.divider,
                                width: 1.5,
                              ),
                            ),
                            child: Text(e.value,
                                style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: active
                                        ? Colors.white
                                        : AppColors.textPrimary)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
              sliver: _items.isEmpty
                  ? SliverToBoxAdapter(child: _EmptyHistory())
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) {
                          if (i < _items.length * 2 - 1) {
                            if (i.isOdd) return const SizedBox(height: 12);
                            return _HistoryCard(item: _items[i ~/ 2]);
                          }
                          return null;
                        },
                        childCount: _items.length * 2 - 1,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StyleInsightsCard extends StatelessWidget {
  final _insights = const [
    _Insight(Icons.palette_outlined, AppColors.accent,
        'Color game is improving',
        'Your last 3 checks all scored high on coordination'),
    _Insight(Icons.trending_up_rounded, AppColors.green,
        'On an upward streak',
        'You\'ve improved by 1.4 points over the past week'),
    _Insight(Icons.star_outline_rounded, Color(0xFFF59E0B),
        'Best category: Date Night',
        'Avg 9.1 — you clearly dress well for dates'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF2D3561)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('✦', style: TextStyle(color: AppColors.card, fontSize: 16)),
              const SizedBox(width: 8),
              Text('Your Style Insights',
                  style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              const Spacer(),
              Text('This month',
                  style: GoogleFonts.dmSans(
                      fontSize: 12, color: Colors.white54)),
            ],
          ),
          const SizedBox(height: 16),
          ..._insights.map((insight) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: insight.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(insight.icon, color: insight.color, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(insight.title,
                              style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          const SizedBox(height: 2),
                          Text(insight.subtitle,
                              style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: Colors.white60,
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

class _Insight {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  const _Insight(this.icon, this.color, this.title, this.subtitle);
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06), blurRadius: 16)
              ],
            ),
            child: const Icon(Icons.camera_alt_outlined,
                size: 40, color: Color(0xFFB0B8C1)),
          ),
          const SizedBox(height: 24),
          Text('No fits checked yet',
              style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 8),
          Text('Upload your first outfit to start\nbuilding your style history',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5)),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const _CheckScreenPlaceholder())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text('Check My First Fit',
                  style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder to avoid circular import — shell handles real nav
class _CheckScreenPlaceholder extends StatelessWidget {
  const _CheckScreenPlaceholder();
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.dmSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(label,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.3)),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final _HistoryItem item;
  const _HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OutfitDetailScreen(
            score: item.score,
            label: item.label,
            date: item.date,
            up: item.up,
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
                Row(
                  children: [
                    Text('${item.score}',
                        style: GoogleFonts.dmSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary)),
                    Text(' /10',
                        style: GoogleFonts.dmSans(
                            fontSize: 14, color: AppColors.textSecondary)),
                    const SizedBox(width: 6),
                    Icon(
                      item.up
                          ? Icons.trending_up_rounded
                          : Icons.trending_down_rounded,
                      size: 18,
                      color: item.up ? AppColors.green : AppColors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(item.label,
                    style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(item.date,
                        style: GoogleFonts.dmSans(
                            fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right,
              size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
