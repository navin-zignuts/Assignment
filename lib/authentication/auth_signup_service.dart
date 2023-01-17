import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/responses/customer.dart';
import 'package:first_app/ui/screens/dashboard/dash_board_screen.dart';
import 'package:first_app/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

import '../ui/screens/login/login_screen.dart';

class signup {
  signup_services(
      {required String email,
      required String password,
      required String username,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      await user?.updateDisplayName(username);

      FirebaseFirestore.instance
          .collection('User')
          .doc(userCredential.user!.uid)
          .set({
        'username': username,
        'uid': userCredential.user!.uid,
        'email': email
      });

      await UserPreferences.saveLoginUserInfo(
          ModelCustomer(id: user!.uid, name: username, email: email));
      print('EMAIL:  ${await UserPreferences.getUserEmail()}');

      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Already Exist!!!')));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Weak Password!!!')));
      }
    }
  }
}
