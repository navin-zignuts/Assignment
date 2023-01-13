import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/resources/string_manager.dart';
import 'package:first_app/ui/screens/dashboard/dash_board_screen.dart';
import 'package:first_app/ui/screens/login/login_screen.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  void timer() {
    Timer(const Duration(seconds: 2), () {

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          if(mounted){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashBoard(),
                ));
          }
        } else {
          if(mounted){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          }
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.Primarytheme,
        child: const Center(
            child: Text(
          StringManager.appName,
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
    );
  }
}
