import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../theme_controller.dart';
import 'result_screen.dart';

enum AnalyzingMode { photo, occasion }

class AnalyzingScreen extends StatefulWidget {
  final AnalyzingMode mode;
  const AnalyzingScreen({super.key, this.mode = AnalyzingMode.photo});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen>
    with TickerProviderStateMixin {
  final _theme = ThemeController();
  late AnimationController _spinCtrl;
  late AnimationController _stepsCtrl;
  late List<Animation<double>> _stepFades;

  List<String> get _steps => widget.mode == AnalyzingMode.occasion
      ? [
          'Reading your occasion...',
          'Matching outfit styles...',
          'Building your look...',
        ]
      : [
          'Checking colors...',
          'Analyzing fit...',
          'Matching occasion...',
        ];

  @override
  void initState() {
    super.initState();
    _theme.addListener(() => setState(() {}));
    _spinCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat();

    _stepsCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3));

    _stepFades = List.generate(
      3,
      (i) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _stepsCtrl,
          curve: Interval(i * 0.33, i * 0.33 + 0.33, curve: Curves.easeIn),
        ),
      ),
    );

    _stepsCtrl.forward();

    Future.delayed(const Duration(milliseconds: 3400), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => ResultScreen(mode: widget.mode)),
      );
    });
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    _stepsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _spinCtrl,
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: Icon(Icons.refresh, color: AppColors.card, size: 40),
                ),
              ),
              const SizedBox(height: 40),
              Text('Analyzing Your Fit',
                  style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 32),
              ..._steps.asMap().entries.map((e) => FadeTransition(
                    opacity: _stepFades[e.key],
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(e.value,
                          style: GoogleFonts.dmSans(
                              fontSize: 16,
                              color: AppColors.textSecondary)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
