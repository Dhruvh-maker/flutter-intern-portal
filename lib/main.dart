import 'package:flutter/material.dart';
import 'package:intern_dashboard/screens/login_screen.dart';
import 'package:intern_dashboard/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/intern_provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/announcements_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => InternProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // Changed initial route to splash screen
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/announcements': (context) => AnnouncementsScreen(),
      },
    );
  }
}
