import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'home_screen.dart';
import 'tips_screen.dart';
import 'check_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class MainShell extends StatefulWidget {
  final String userName;
  const MainShell({super.key, required this.userName});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _navIndex = 0;

  int get _stackIndex {
    if (_navIndex == 3) return 2;
    if (_navIndex == 4) return 3;
    return _navIndex;
  }

  void _onTap(int i) {
    if (i == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const CheckScreen()));
    } else {
      setState(() => _navIndex = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: IndexedStack(
        index: _stackIndex,
        children: [
          HomeScreen(
            userName: widget.userName,
            onStyleTipsTap: () => setState(() => _navIndex = 1),
            onViewAllTap: () => setState(() => _navIndex = 3),
          ),
          const TipsScreen(),
          const HistoryScreen(),
          ProfileScreen(userName: widget.userName),
        ],
      ),
      bottomNavigationBar: FitGradeNavBar(
        currentIndex: _navIndex,
        onTap: _onTap,
      ),
    );
  }
}
