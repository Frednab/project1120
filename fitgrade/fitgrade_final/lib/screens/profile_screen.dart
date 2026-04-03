import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import '../widgets/common.dart';
import 'splash_screen.dart';
import 'settings_screen.dart';
import 'notifications_screen.dart';

// ─── Data classes (Dart 2.x compatible — no record syntax) ───────────────────
class _ProFeature {
  final String label;
  final IconData icon;
  const _ProFeature(this.label, this.icon);
}

class _HelpItem {
  final String emoji;
  final String label;
  final String subtitle;
  const _HelpItem(this.emoji, this.label, this.subtitle);
}

const _proFeatures = [
  _ProFeature('Unlimited outfit checks', Icons.all_inclusive),
  _ProFeature('Full color & complexion analysis', Icons.palette_outlined),
  _ProFeature('Priority AI feedback', Icons.bolt_outlined),
  _ProFeature('Weekly personalized style report', Icons.bar_chart_outlined),
];

const _helpItems = [
  _HelpItem('📧', 'Email Us', 'support@fitgrade.app'),
  _HelpItem('💬', 'Live Chat', 'Available 9am–6pm EST'),
  _HelpItem('📖', 'FAQ', 'Common questions answered'),
];

class ProfileScreen extends StatefulWidget {
  final String userName;
  const ProfileScreen({super.key, required this.userName});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    final initials = widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'F';
    final email = '${widget.userName.toLowerCase()}@email.com';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile',
                  style: GoogleFonts.dmSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 24),

              // Profile card
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                              color: AppColors.primary, shape: BoxShape.circle),
                          child: Center(
                            child: Text(initials,
                                style: GoogleFonts.dmSans(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.userName,
                                  style: GoogleFonts.dmSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary)),
                              Text(email,
                                  style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SettingsScreen(
                                      userName: widget.userName,
                                      email: email,
                                    )),
                          ),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.iconBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.settings_outlined,
                                size: 20, color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(height: 1, color: AppColors.divider),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ProfileStat(value: '24', label: 'Checks'),
                        _VerticalDivider(),
                        _ProfileStat(value: '8.1', label: 'Avg Score'),
                        _VerticalDivider(),
                        _ProfileStat(value: '12', label: 'Saved'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Upgrade banner
              GestureDetector(
                onTap: () => _showUpgradeSheet(context),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF7B2FF7), Color(0xFFAB5CF5)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('CURRENT PLAN',
                              style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                  letterSpacing: 1)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Basic',
                                style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Free',
                          style: GoogleFonts.dmSans(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                      const SizedBox(height: 4),
                      Text('5 checks remaining this month',
                          style: GoogleFonts.dmSans(
                              fontSize: 14, color: Colors.white70)),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Upgrade to Pro',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Menu items
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _MenuItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SettingsScreen(
                            userName: widget.userName,
                            email: email,
                          ))),
                    ),
                    Divider(height: 1, indent: 20, color: AppColors.divider),
                    _MenuItem(
                      icon: Icons.notifications_outlined,
                      label: 'Notifications',
                      badge: '2',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                    ),
                    Divider(height: 1, indent: 20, color: AppColors.divider),
                    _MenuItem(
                      icon: Icons.help_outline,
                      label: 'Help & Support',
                      onTap: () => _showHelpSheet(context),
                    ),
                    Divider(height: 1, indent: 20, color: AppColors.divider),
                    _MenuItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      danger: true,
                      onTap: () => _showLogoutDialog(context),
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

  void _showUpgradeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7B2FF7), Color(0xFF4A1A9E)],
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('✦', style: TextStyle(fontSize: 36, color: Colors.white)),
            const SizedBox(height: 12),
            Text('FitGrade Pro',
                style: GoogleFonts.dmSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
            const SizedBox(height: 8),
            Text('Everything you need to dress with confidence',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                    fontSize: 14, color: Colors.white70)),
            const SizedBox(height: 28),
            ..._proFeatures.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(f.icon, color: AppColors.card, size: 16),
                      ),
                      const SizedBox(width: 14),
                      Text(f.label,
                          style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text('Start Pro — \$4.99/month',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.accent)),
                  Text('Cancel anytime',
                      style: GoogleFonts.dmSans(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showHelpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            Text('Help & Support',
                style: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 20),
            ..._helpItems.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardSecondary,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        Text(item.emoji, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.label,
                                  style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary)),
                              Text(item.subtitle,
                                  style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 14, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Logout?',
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700, fontSize: 18)),
        content: Text('You can always log back in to your account.',
            style: GoogleFonts.dmSans(
                fontSize: 14, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.dmSans(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SplashScreen()),
              (route) => false,
            ),
            child: Text('Logout',
                style: GoogleFonts.dmSans(
                    color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.dmSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary)),
        const SizedBox(height: 2),
        Text(label,
            style: GoogleFonts.dmSans(
                fontSize: 13, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 40, color: AppColors.iconBg);
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  final String? badge;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: danger
                    ? Colors.red.shade50
                    : AppColors.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  size: 18,
                  color: danger
                      ? Colors.red.shade400
                      : AppColors.textSecondary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: danger
                          ? Colors.red.shade400
                          : AppColors.textPrimary)),
            ),
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badge!,
                    style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
              const SizedBox(width: 8),
            ],
            Icon(Icons.chevron_right,
                size: 20, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
