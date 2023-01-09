import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/login_page.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShowPass = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  //textControllers
  final TextEditingController _email = TextEditingController();
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
                  color: ColorManager.Primarytheme,
                ),
                SizedBox(
                  height: 20,
                ),

                //WELCOME BACK TEXT
                Text(
                  'Welcome Fitness Enthusiast !!!',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ColorManager.Primarytheme),
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
                        color: ColorManager.Primarytheme),
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
                    controller: _email,
                    decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: ColorManager.Primarytheme),
                        prefixIcon: Icon(
                          Icons.mail,
                          color: ColorManager.Primarytheme,
                        )),
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
                      controller: _pass,
                      obscureText: !isShowPass,
                      decoration: InputDecoration(
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.Primarytheme)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.Primarytheme)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.Primarytheme)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.Primarytheme)),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: ColorManager.Primarytheme),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: ColorManager.Primarytheme,
                          ),
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
                              child: Icon(
                                isShowPass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: ColorManager.Primarytheme,
                              ))),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _confirmPass,
                    obscureText: !isShowPass,
                    decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorManager.Primarytheme)),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: ColorManager.Primarytheme),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: ColorManager.Primarytheme,
                        ),
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
                            child: Icon(
                              isShowPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: ColorManager.Primarytheme,
                            ))),
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
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: _email.text, password: _pass.text);
                        if (userCredential != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User Already Exist!!!')));
                        } else if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Weak Password!!!')));
                        }
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: ColorManager.Primarytheme,
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
                      'Already have an account?',
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
                            color: ColorManager.Primarytheme,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                isLoading
                    ? Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: ColorManager.Primarytheme,
                        ))
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
