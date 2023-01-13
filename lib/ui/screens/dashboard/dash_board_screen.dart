import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/resources/string_manager.dart';
import 'package:first_app/ui/dialog/alert_dialog.dart';
import 'package:first_app/ui/screens/dashboard/home_sceen.dart';
import 'package:first_app/ui/screens/dashboard/whish_list.dart';
import 'package:first_app/ui/screens/login/login_screen.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int indx = 0;



  List<Widget> screens = [
    // ignore: prefer_const_constructors
    // Center(
    //   child: const Text(
    //     StringManager.HomeTitle,
    //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //   ),
    // ),
    HomeWithDash(),
    const Center(
      child: Text(StringManager.Vendors,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    const WLists(),
    const Center(
      child: Text(StringManager.Categories,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    const Center(
      child: Text(StringManager.more,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog(
            context: context,
            builder: (context) {
               return Alert_Dialog.exitdialog(context);

            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(value);
        }
      },
      child: SafeArea(
        child: Scaffold(

          bottomNavigationBar: BottomNavigationBar(
              currentIndex: indx,
              onTap: (value) {
                setState(() {
                  indx = value;
                });
              },
              unselectedItemColor: Colors.grey,
              fixedColor: ColorManager.Primarytheme,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: StringManager.HomeTitle),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: StringManager.Vendors),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: StringManager.Lists),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: StringManager.Categories),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.more), label: StringManager.Categories),
              ]),

          body: screens[indx],
        ),
      ),
    );
  }
}
