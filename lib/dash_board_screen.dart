import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/login_page.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int indx = 0;

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
    Center(
      child: Text('Lists',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
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
          appBar: AppBar(
            title: Text('Dashbooard'),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: indx,
              onTap: (value) {
                setState(() {
                  indx = value;
                });
              },
              unselectedItemColor: Colors.grey,
              fixedColor: Colors.blue,
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
                    accountName: Text(
                      'Nisarg Chaniyara',
                      style: TextStyle(fontSize: 15),
                    ),
                    accountEmail: Text('nisargc@zignuts.com')),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text(' Payment method'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text(' Address '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text(' Household'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('LogOut'),
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
                                      child: Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'))
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
