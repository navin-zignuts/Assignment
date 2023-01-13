import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/resources/string_manager.dart';
import 'package:first_app/ui/screens/login/login_screen.dart';
import 'package:first_app/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class Alert_Dialog {
  static signoutalertdialog (BuildContext context){
    return AlertDialog(
        backgroundColor: Colors.grey.shade200,
        title:
        const Text(StringManager.AlertTitle),
        content: Text(StringManager.LogoutAlertDialogMessage),
        actions: [
          TextButton(
              onPressed: () async{
                FirebaseAuth.instance.signOut();
                await UserPreferences.clearDetailsOnSignOut();
                print('EMAIL:  ${await UserPreferences.getUserEmail()}');

                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const LoginPage()),
                        (route) => false);
              },
              child: Text(
                StringManager.Yes,
                style: TextStyle(
                    color: ColorManager.Primarytheme),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(StringManager.No,
                  style: TextStyle(
                      color:
                      ColorManager.Primarytheme)))
        ]);
  }

  static exitdialog(BuildContext context){
return AlertDialog(
  title: const Text(StringManager.AlertTitle),
  content: const Text(StringManager.AlertMessege),
  actions: [
    ElevatedButton(
        onPressed: () => Navigator.of(context).pop(false),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white),
        child: const Text(StringManager.No)),
    ElevatedButton(
        onPressed: () => Navigator.of(context).pop(true),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white),
        child: const Text(StringManager.Exit)),
  ],
);
  }
}