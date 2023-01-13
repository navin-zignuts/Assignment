import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/ui/screens/dashboard/dash_board_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/login/login_screen.dart';

class signup{
  signup_services({required String email,required String password,required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DashBoard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('User Already Exist!!!')));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Weak Password!!!')));
      }
    }
  }
}