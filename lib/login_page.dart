import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/dash_board_screen.dart';
import 'package:first_app/forgot_password_page.dart';
import 'package:first_app/google_sign_in.dart';
import 'package:first_app/singup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPass = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: WillPopScope(
          onWillPop: () async {
            final value = await showDialog<bool>(
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
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),

                    //LOCK ICON
                    Icon(
                      Icons.lock,
                      size: 80,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //WELCOME BACK TEXT
                    Text(
                      'Welcome Back Fitness Enthusiast',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //LOGIN TEXT
                    Container(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //INPUT FIELD USERNAME
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade900)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue.shade900)),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.mail)),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          // Check if the entered email has the right format
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          // Return null if the entered email is valid
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //INPUT FIELD PASSWORD
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          obscureText: !isShowPass,
                          decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue.shade900)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue.shade900)),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isShowPass) {
                                        isShowPass = false;
                                      } else {
                                        isShowPass = true;
                                      }
                                    });
                                  },
                                  child: Icon(isShowPass
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            if (value.length < 6) {
                              return "Password must be atleast 6 characters long";
                            }
                            if (value.length > 20) {
                              return "Password must be less than 20 characters";
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return "Password must contain a number";
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //FORGOT PASSWORD
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text('Forgot Password?',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //LOGIN BUTTON
                    InkWell(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                            if (userCredential.user != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoard()));
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User Not Found')));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Invalid Password')));
                            }
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //DON'T HAVE AN ACCOUNT? SIGNUP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            ' SignUp',
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //Google LOGIN BUTTON
                    InkWell(
                      onTap: () async {
                        if (await Google_Sign_In().signInWithGoogle() != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await Google_Sign_In().signInWithGoogle();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard()));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 25,
                                width: 25,
                                child: Image.asset('lib/assets/google.png')),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign in Google ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ))
                        : SizedBox()
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
