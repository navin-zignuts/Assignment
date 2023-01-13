
import 'package:first_app/authentication/auth_signup_service.dart';
import 'package:first_app/resources/string_manager.dart';
import 'package:first_app/ui/screens/login/login_screen.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/utilites/common_utilities.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  signup _signup = signup();
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
                const SizedBox(
                  height: 20,
                ),

                //REGISTRATION ICON
                Icon(
                  Icons.person,
                  size: 80,
                  color: ColorManager.Primarytheme,
                ),
                const SizedBox(
                  height: 20,
                ),

                //WELCOME BACK TEXT
                Text(
                  StringManager.WelcomeMessageSignUp,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ColorManager.Primarytheme),
                ),
                const SizedBox(
                  height: 20,
                ),

                //SIGNUP TEXT
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Text(
                    StringManager.SignUpTitle,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.Primarytheme),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //INPUT FIELD USERNAME
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _email,
                    decoration: CommonUtilities.getTextInputDecor(StringManager.Email, Icons.mail,colorIcon: ColorManager.Primarytheme,colorBorder: ColorManager.Primarytheme),

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
                const SizedBox(
                  height: 20,
                ),

                //INPUT FIELD PASSWORD
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _pass,
                      obscureText: !isShowPass,
                      decoration: CommonUtilities.getTextInputDecorPass(colorIcon: ColorManager.Primarytheme,colorBorder: ColorManager.Primarytheme,
                          isLocked: isShowPass, StringManager.Password, Icons.lock, () {
                            setState(() {
                              if (isShowPass) {
                                isShowPass = false;
                              } else {
                                isShowPass = true;
                              }
                            });
                          }),
                      // ignore: body_might_complete_normally_nullable
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManager.RequiredError;
                        }
                        if (value.length < 6) {
                          return StringManager.PasswordLength6Error;
                        }
                        if (value.length > 20) {
                          return StringManager.PasswordLength20Error;
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return StringManager.PasswordNumberError;
                        }
                      }),
                ),

                const SizedBox(
                  height: 20,
                ),

                //INPUT FIELD CONFIRM PASSWORD
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _confirmPass,
                    obscureText: !isShowPass,
                    decoration: CommonUtilities.getTextInputDecorPass(colorIcon: ColorManager.Primarytheme,colorBorder: ColorManager.Primarytheme,
                        isLocked: isShowPass, StringManager.ConfirmPass, Icons.lock, () {
                          setState(() {
                            if (isShowPass) {
                              isShowPass = false;
                            } else {
                              isShowPass = true;
                            }
                          });
                        }),
                    validator: (value) {
                      if (value != _pass.text) {
                        return StringManager.PasswordMatchError;
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //SIGNUP BUTTON
                InkWell(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await _signup.signup_services(email: _email.text, password: _pass.text,context: context);
                      setState(() {
                        isLoading = false;
                      });

                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: ColorManager.Primarytheme,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      StringManager.SignUpTitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //DON'T HAVE AN ACCOUNT? SIGNUP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        StringManager.Login,
                        style: TextStyle(
                            color: ColorManager.Primarytheme,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: ColorManager.Primarytheme,
                        ))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
