import 'package:aimedscribble/screens/auth/login.dart';
import 'package:flutter/material.dart';

import '../../uitilities/colors.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_icon_button.dart';
import '../../widgets/text_field_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLoading = false;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Sign Up",
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
                      iconPath: "assets/email_perso.png",
                      hintText: 'Email',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
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
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFieldInput(
                      iconPath: "assets/lock.png",
                      hintText: 'Confirm Password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: true,
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
                          text: 'Sign Up',
                          function: () {},
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "or",
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
                          "If you have an account ",
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
                                    builder: (context) => const Login(),
                                  ));
                            },
                            child: const Text(
                              "Sign In",
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
                          text: 'Sign up with Google',
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
                          text: 'Sign up with Microsoft',
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
                          text: 'Sign up with Apple',
                          function: () {},
                          iconPath: "assets/apple.png",
                        )),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
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
