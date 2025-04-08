import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'screens/home_screen.dart';
import 'config/theme.dart';

void main() {
  // Enable URL strategies for web
  setUrlStrategy(PathUrlStrategy());
  
  // Initialize Animate package
  Animate.restartOnHotReload = true;
  
  runApp(const YoutopiaApp());
}

class YoutopiaApp extends StatelessWidget {
  const YoutopiaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtopia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: AppTheme.lightColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: AppTheme.darkColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme()
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      themeMode: ThemeMode.dark, // Default to dark theme for ethereal feel
      home: const HomeScreen(),
    );
  }
}
