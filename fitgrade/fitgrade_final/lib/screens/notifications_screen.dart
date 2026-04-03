import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';

class _Notif {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final bool unread;
  _Notif(this.icon, this.color, this.title, this.body, this.time, this.unread);
}

final _notifs = [
  _Notif(Icons.auto_awesome_outlined, AppColors.accent,
      'Style Insight Ready',
      'Your color coordination has improved by 12% this week. Keep it up!',
      'Just now', true),
  _Notif(Icons.star_outline_rounded, const Color(0xFFF59E0B),
      'New Best Score!',
      'Your Date Night outfit scored 9.1 — your personal best.',
      '2h ago', true),
  _Notif(Icons.tips_and_updates_outlined, AppColors.green,
      'Weekly Style Tip',
      'Try pairing earthy tones this week — rust, camel, and olive are trending.',
      'Yesterday', false),
  _Notif(Icons.bar_chart_outlined, AppColors.primary,
      'Weekly Report',
      'You completed 5 checks this week with an average score of 8.1.',
      '2 days ago', false),
  _Notif(Icons.palette_outlined, AppColors.accent,
      'Color Tip',
      'For your complexion, deep navy and burgundy work best for evening outings.',
      '3 days ago', false),
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _theme = ThemeController();

  late List<bool> _unread;

  @override
  void initState() {
    super.initState();
    _theme.addListener(() => setState(() {}));
    _unread = _notifs.map((n) => n.unread).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = _unread.any((u) => u);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
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
                  Expanded(
                    child: Text('Notifications',
                        style: GoogleFonts.dmSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary)),
                  ),
                  if (hasUnread)
                    GestureDetector(
                      onTap: () =>
                          setState(() => _unread = List.filled(_notifs.length, false)),
                      child: Text('Mark all read',
                          style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                itemCount: _notifs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final n = _notifs[i];
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _unread[i] = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _unread[i]
                            ? AppColors.card
                            : AppColors.cardSecondary,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _unread[i]
                              ? AppColors.accent.withOpacity(0.4)
                              : AppColors.divider,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: n.color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:
                                Icon(n.icon, color: n.color, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(n.title,
                                          style: GoogleFonts.dmSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textPrimary)),
                                    ),
                                    if (_unread[i])
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                            color: AppColors.accent,
                                            shape: BoxShape.circle),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(n.body,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                        height: 1.4)),
                                const SizedBox(height: 6),
                                Text(n.time,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 11,
                                        color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
