import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linker/home.dart';
import 'package:linker/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Your main home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final supabase = Supabase.instance.client;
    final bool isSignedIn = supabase.auth.currentSession != null;
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isSignedIn ? HomePage() : LoginScreen(),), // Navigate to Home
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Image.asset('assets/images/Group.png', width: 150), // Your logo
      ),
    );
  }
}
