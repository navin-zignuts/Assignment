import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/resources/string_manager.dart';
import 'package:first_app/ui/dialog/alert_dialog.dart';
import 'package:flutter/material.dart';

class HomeWithDash extends StatefulWidget {
  const HomeWithDash({super.key});

  @override
  State<HomeWithDash> createState() => _HomeWithDashState();
}

class _HomeWithDashState extends State<HomeWithDash> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? username = FirebaseAuth.instance.currentUser?.displayName;
  // ignore: non_constant_identifier_names
  String? user_id = FirebaseAuth.instance.currentUser?.uid;

  //final _login = Login();
  //User? _user;

  @override
  void initState() {
    // _user = _login.getUser();
    // setState(() {
    //   userEmail = _user?.email;
    //   username = _user?.displayName;
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: ColorManager.Primarytheme),
                currentAccountPicture: CircleAvatar(
                  // ignore: sort_child_properties_last
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: ColorManager.Primarytheme,
                  ),
                  backgroundColor: Colors.white,
                ),
                // ignore: prefer_const_constructors
                accountName: Text(
                  '$username',
                  style: const TextStyle(fontSize: 15),
                ),
                accountEmail: Text('$userEmail')),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text(StringManager.PaymentMethod),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text(StringManager.Address),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text(StringManager.Password),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(StringManager.Household),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(StringManager.Logout),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      // ignore: avoid_unnecessary_containers
                      return Container(
                          child: Alert_Dialog.signoutalertdialog(context));
                    });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.Primarytheme,
        title: const Text(StringManager.Dashboard),
        centerTitle: true,
      ),
    );
  }
}
