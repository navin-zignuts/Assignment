import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/responses/customer.dart';
import 'package:first_app/ui/screens/dashboard/dash_board_screen.dart';
import 'package:first_app/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class Login{
  login_services ({required String email, required String password, required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(
          email: email,
          password: password,);

      await UserPreferences.saveLoginUserInfo(ModelCustomer(email: email,id: userCredential.user!.uid,name: userCredential.user!.displayName));
      print('EMAIL Login: ${await UserPreferences.getUserEmail()}');

      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DashBoard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('User Not Found')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Password')));
      }
    }


  }
  User? getUser(){
    return FirebaseAuth.instance.currentUser;
  }
}