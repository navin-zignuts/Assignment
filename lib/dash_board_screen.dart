import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/google_sign_in.dart';
import 'package:first_app/lists.dart';
import 'package:first_app/login_page.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int indx = 0;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  List<Widget> screens = [
    Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text('Vendors',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    WLists(),
    Center(
      child: Text('Categories',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('More',
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
              return AlertDialog(
                title: Text('Alert?'),
                content: Text('Are you sure want to exit?'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      child: Text('NO')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      child: Text('Exit')),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(value);
        }
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: ColorManager.Primarytheme,
          //   title: Text('Dashbooard'),
          //   centerTitle: true,
          // ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: indx,
              onTap: (value) {
                setState(() {
                  indx = value;
                });
              },
              unselectedItemColor: Colors.grey,
              fixedColor: ColorManager.Primarytheme,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Vendors'),
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lists'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.more), label: 'More'),
              ]),
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: ColorManager.Primarytheme),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: ColorManager.Primarytheme,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    accountName: Text(
                      '',
                      style: TextStyle(fontSize: 15),
                    ),
                    accountEmail: Text('$userEmail')),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Payment method'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: const Text('Address'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.password),
                  title: const Text('Password'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Household'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: AlertDialog(
                                backgroundColor: Colors.grey.shade200,
                                title: Text('Are you sure want to logout?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        if (FirebaseAuth.instance.currentUser !=
                                            null) {
                                          await FirebaseAuth.instance.signOut();
                                        }

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                            (route) => false);
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: ColorManager.Primarytheme),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No',
                                          style: TextStyle(
                                              color:
                                                  ColorManager.Primarytheme)))
                                ]),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
          body: screens[indx],
        ),
      ),
    );
  }
}
