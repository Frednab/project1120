import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String userName;
  final String email;
  const SettingsScreen({
    super.key,
    this.userName = 'Fredrick',
    this.email = 'fredrick@email.com',
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _weeklyReport = true;
  bool _styleInsights = false;
  final ThemeController _themeController = ThemeController();

  @override
  void initState() {
    super.initState();
    _themeController.addListener(_onThemeChange);
  }

  void _onThemeChange() => setState(() {});

  @override
  void dispose() {
    _themeController.removeListener(_onThemeChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Icon(Icons.arrow_back, size: 20, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('Settings',
                      style: GoogleFonts.dmSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel('Preferences'),
                    const SizedBox(height: 12),
                    _SettingsCard(children: [
                      _ToggleTile(
                        icon: Icons.dark_mode_outlined,
                        label: 'Dark Mode',
                        subtitle: 'Switch to a darker interface',
                        value: _themeController.isDarkMode,
                        onChanged: (v) {
                          _themeController.setDarkMode(v);
                          setState(() {});
                        },
                      ),
                    ]),
                    const SizedBox(height: 20),
                    _SectionLabel('Notifications'),
                    const SizedBox(height: 12),
                    _SettingsCard(children: [
                      _ToggleTile(
                        icon: Icons.notifications_outlined,
                        label: 'Push Notifications',
                        subtitle: 'Get style tips and reminders',
                        value: _notifications,
                        onChanged: (v) => setState(() => _notifications = v),
                      ),
                      _Divider(),
                      _ToggleTile(
                        icon: Icons.bar_chart_outlined,
                        label: 'Weekly Style Report',
                        subtitle: 'A summary of your looks each week',
                        value: _weeklyReport,
                        onChanged: (v) => setState(() => _weeklyReport = v),
                      ),
                      _Divider(),
                      _ToggleTile(
                        icon: Icons.auto_awesome_outlined,
                        label: 'Style Insights',
                        subtitle: 'Personalised color & trend nudges',
                        value: _styleInsights,
                        onChanged: (v) => setState(() => _styleInsights = v),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    _SectionLabel('Account'),
                    const SizedBox(height: 12),
                    _SettingsCard(children: [
                      _NavTile(
                        icon: Icons.person_outline,
                        label: 'Edit Profile',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => EditProfileScreen(
                              userName: widget.userName,
                              email: widget.email,
                            ))),
                      ),
                      _Divider(),
                      _NavTile(
                        icon: Icons.lock_outline,
                        label: 'Change Password',
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const ChangePasswordScreen())),
                      ),
                      _Divider(),
                      _NavTile(
                        icon: Icons.delete_outline,
                        label: 'Delete Account',
                        danger: true,
                        onTap: () => _showDeleteDialog(context),
                      ),
                    ]),
                    const SizedBox(height: 32),
                    Center(
                      child: Text('FitGrade v1.0.0',
                          style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColors.textSecondary)),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Delete Account?',
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700, fontSize: 18)),
        content: Text(
            'This will permanently delete your account and all your outfit history.',
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.dmSans(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Delete',
                style: GoogleFonts.dmSans(
                    color: Colors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
            letterSpacing: 0.5));
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12)
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: AppColors.iconBg,
                borderRadius: BorderRadius.circular(10)),
            child:
                Icon(icon, size: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                Text(subtitle,
                    style: GoogleFonts.dmSans(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: danger
                          ? Colors.red.shade400
                          : AppColors.textPrimary)),
            ),
            Icon(Icons.chevron_right,
                size: 18, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
        height: 1, indent: 66, color: Colors.grey.shade100);
  }
}
