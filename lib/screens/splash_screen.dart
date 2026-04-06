import 'package:flutter/material.dart';
import 'package:lilac_movie_app/screens/bottombar/bottombar_screens.dart';
import 'package:lilac_movie_app/screens/bottombar/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomBarScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Image.asset(
            height: 100,
            width: 100,
            'assets/app_logo_movie.jpg',
          ),
        ),
      ),
    );
  }
}

// Dummy HomeScreen}
