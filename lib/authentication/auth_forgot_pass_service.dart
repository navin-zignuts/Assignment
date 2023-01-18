import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot {
  // ignore: non_constant_identifier_names
  forgot_pass_service({required String email, context}) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: email,
          )
          .then((value) => Navigator.of(context).pop());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password Reset Link Successfully Sent!!!')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User Not Found!!!')));
      }
    }
  }
}
