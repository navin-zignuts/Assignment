import 'package:first_app/login_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShowPass = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                //REGISTRATION ICON
                Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),

                //WELCOME BACK TEXT
                Text(
                  'Welcome Fitness Enthusiast !!!',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.blueGrey),
                ),
                SizedBox(
                  height: 20,
                ),

                //SIGNUP TEXT
                Container(
                  child: Text(
                    'Sign Up',
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
                      controller: _pass,
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
                  height: 20,
                ),

                //INPUT FIELD CONFIRM PASSWORD
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _confirmPass,
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
                        labelText: 'Confirm Password',
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
                      if (value != _pass.text) {
                        return 'Password Doesn\'t Match';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //SIGNUP BUTTON
                InkWell(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
                      'Sign Up',
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
                      'Already Have an Account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        ' Login',
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
    );
  }
}
