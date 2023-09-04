import 'package:aimedscribble/Models/UserModel.dart';
import 'package:aimedscribble/screens/auth/sign_up.dart';
import 'package:aimedscribble/screens/dashboard/dashboard.dart';
import 'package:aimedscribble/uitilities/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../uitilities/FIrebaseServices.dart';
import '../../uitilities/colors.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_icon_button.dart';
import '../../widgets/text_field_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseServices _firebaseServices = FirebaseServices();
  void _handleLogin() {
    _firebaseServices.login(
      _emailController,
      _passwordController,
      context,
      myImage,
    );
    setState(() {
      myImage = globaluserdata!.profileImageURL;
      print('my Image $myImage');
    });
    // EasyLoading.showSuccess("Done");
  }

  GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Add GlobalKey for the Form

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldInput(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        iconPath: "assets/email_perso.png",
                        hintText: 'Email',
                        textInputType: TextInputType.text,
                        textEditingController: _emailController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldInput(
                        iconPath: "assets/lock.png",
                        hintText: 'Password',
                        textInputType: TextInputType.text,
                        textEditingController: _passwordController,
                        isPass: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          // Add more validation rules here if needed
                          return null; // Return null if validation passes
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 60,
                        width: screenWidth,
                        child: AuthButton(
                          backgroundColor: blueColor,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          text: 'Sign In',
                          function: _handleLogin,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: text2Color,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Dont have an account? Lets ",
                            style: TextStyle(
                              color: text2Color,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ));
                              },
                              child: const Text(
                                "Sign up!",
                                style: TextStyle(
                                  color: blueColor,
                                  fontSize: 13,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                          height: 60,
                          width: screenWidth,
                          child: AuthIconButton(
                            backgroundColor: Colors.white,
                            borderColor: text2Color,
                            textColor: text2Color,
                            text: 'Log in with Google',
                            function: () {},
                            iconPath: "assets/google.png",
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                          height: 60,
                          width: screenWidth,
                          child: AuthIconButton(
                            backgroundColor: Colors.white,
                            borderColor: text2Color,
                            textColor: text2Color,
                            text: 'Log in with Microsoft',
                            function: () {},
                            iconPath: "assets/lmicrosoft.png",
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                          height: 60,
                          width: screenWidth,
                          child: AuthIconButton(
                            backgroundColor: Colors.white,
                            borderColor: text2Color,
                            textColor: text2Color,
                            text: 'Log in with Apple',
                            function: () {},
                            iconPath: "assets/apple.png",
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/bgImage.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
