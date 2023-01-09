import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/dash_board_screen.dart';
import 'package:first_app/login_page.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashBoard(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorManager.Primarytheme,
        child: Center(
            child: Text(
          'GroceryApp',
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
    );
  }
}
