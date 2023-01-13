import 'package:first_app/authentication/auth_login_service.dart';
import 'package:first_app/authentication/google_sign_in.dart';
import 'package:first_app/resources/string_manager.dart';
import 'package:first_app/resources/styles_manager.dart';
import 'package:first_app/ui/dialog/alert_dialog.dart';
import 'package:first_app/ui/screens/dashboard/dash_board_screen.dart';
import 'package:first_app/ui/screens/forgot_password/forgot_pwd_screen.dart';
import 'package:first_app/resources/assets_manager.dart';
import 'package:first_app/resources/color_manager.dart';
import 'package:first_app/ui/screens/signup/singup_screen.dart';
import 'package:first_app/utilites/common_utilities.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Login _login = Login();
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
                  return Alert_Dialog.exitdialog(context);
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
                    const SizedBox(
                      height: 20,
                    ),

                    //LOCK ICON
                    Icon(
                      Icons.lock,
                      size: 80,
                      color: ColorManager.Primarytheme,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //WELCOME BACK TEXT
                    Text(
                      StringManager.WelcomeMessageLogin,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ColorManager.Primarytheme),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //LOGIN TEXT
                    Text(
                      StringManager.LoginTitle,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.Primarytheme),
                    ),
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
                    ),

                    //INPUT FIELD PASSWORD
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _passwordController,
                          obscureText: !isShowPass,
                          decoration: CommonUtilities.getTextInputDecorPass(
                              colorIcon: ColorManager.Primarytheme,
                              isLocked: isShowPass,
                              StringManager.Password,
                              Icons.lock, () {
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
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text(StringManager.ForgotPassword,
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //LOGIN BUTTON
                    InkWell(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await _login.login_services(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child:
                          LoginButtonText(labelTxt: StringManager.LoginTitle),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //DON'T HAVE AN ACCOUNT? SIGNUP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Text(
                          StringManager.DontHaveAccount,
                          style: TextStyle(color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: Text(
                            StringManager.SignUp,
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

                    //Google LOGIN BUTTON
                    InkWell(
                      onTap: () async {
                        await Google_Sign_In().signInWithGoogle();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: buildCenter(),
                      ),
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
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  Center buildCenter() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 25, width: 25, child: Image.asset(ImageAssets.GoogleLogo)),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'Sign in with Google ',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    ));
  }
}

class LoginButtonText extends StatelessWidget {
  String labelTxt;

  LoginButtonText({Key? key, required this.labelTxt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: ColorManager.Primarytheme,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        labelTxt,
        style: getBoldStyle(color: Colors.white, fontSize: 16),
      )),
    );
  }
}
