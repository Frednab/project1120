import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/main_shell.dart';
import 'theme_controller.dart';
import 'theme.dart';

const supabaseUrl = 'https://hnkoxzengyqprongevee.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhua294emVuZ3lxcHJvbmdldmVlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2MzQ0NTcsImV4cCI6MjA4OTIxMDQ1N30.im2VnqQcCkQjfyxauAGuEzbyqPjqK8LdRltAR_7x4TI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const FitGradeApp());
}

final supabase = Supabase.instance.client;

class FitGradeApp extends StatefulWidget {
  const FitGradeApp({super.key});
  @override
  State<FitGradeApp> createState() => _FitGradeAppState();
}

class _FitGradeAppState extends State<FitGradeApp> {
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
    final isDark = _themeController.isDarkMode;
    return MaterialApp(
      title: 'FitGrade',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B2FF7),
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(),
        useMaterial3: true,
      ),
      home: const _AuthGate(),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        final session = supabase.auth.currentSession;
        if (session != null) {
          final user = supabase.auth.currentUser!;
          final name = user.userMetadata?['name'] as String? ??
              user.email?.split('@')[0] ?? 'User';
          return MainShell(userName: name);
        }
        return const SplashScreen();
      },
    );
  }
}
