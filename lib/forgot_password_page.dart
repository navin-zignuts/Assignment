import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (conext) => LoginPage()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
        ),
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Container(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),

              Container(
                child: Text('Password reset link will be send on your email',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.blueGrey)),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              //INPUT FIELD USERNAME
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade900)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade900)),
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
                height: MediaQuery.of(context).size.height * 0.045,
              ),

              //Reset Button
              InkWell(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(
                            email: _emailController.text.trim(),
                          )
                          .then((value) => Navigator.of(context).pop());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Password Reset Link Successfully Sent!!!')));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User Not Found!!!')));
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
                    'Reset',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              isLoading
                  ? Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ))
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
