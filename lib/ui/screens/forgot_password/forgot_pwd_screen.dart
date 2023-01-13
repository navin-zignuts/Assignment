
import 'package:first_app/authentication/auth_forgot_pass_service.dart';
import 'package:first_app/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../utilites/common_utilities.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Forgot _forgot = Forgot();
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Icon(
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
              // ignore: avoid_unnecessary_containers
              Container(
                child: Text(
                  StringManager.ResetPass,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.Primarytheme),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),

              // ignore: avoid_unnecessary_containers
              Container(
                child:  Text(
                    StringManager.ResetPassMessage,
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: ColorManager.Primarytheme)),
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
                  decoration: CommonUtilities.getTextInputDecor(
                     StringManager.Email, Icons.mail,
                      colorBorder: ColorManager.Primarytheme,
                      colorIcon: ColorManager.Primarytheme),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return StringManager.EmailError;
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return StringManager.EmailValidError;
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

                    await _forgot.forgot_pass_service(email: _emailController.text);

                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: ColorManager.Primarytheme,
                      borderRadius: BorderRadius.circular(10)),
                  // ignore: prefer_const_constructors
                  child: Center(
                      child:  Text(
                    StringManager.Reset,
                    style: TextStyle(
                        color: ColorManager.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              isLoading
                  // ignore: prefer_const_constructors
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(
                        color: Colors.blue,
                      ))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
