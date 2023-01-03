import 'package:first_app/dash_board_screen.dart';
import 'package:first_app/singup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPass = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
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
                          labelText: 'Username',
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
                        Text('Forgot Password?',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //LOGIN BUTTON
                  InkWell(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashBoard()));
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
                        'Don\'t Have an Account?',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
