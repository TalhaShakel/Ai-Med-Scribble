import 'dart:typed_data';

import 'package:aimedscribble/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../uitilities/FIrebaseServices.dart';
import '../../uitilities/colors.dart';
import '../../uitilities/utils.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_icon_button.dart';
import '../../widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  TextEditingController address = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseServices _firebaseServices = FirebaseServices();
  Uint8List? _image;
  String photoUrl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    if (im != null) {
      // Set state because we need to display the image we selected on the circle avatar
      setState(() {
        _image = im;
      });

      // Upload the image to Firebase Storage
    } else {
      // Handle the case where no image was selected
      print('No image selected.');
    }
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    // You can add more custom validation rules for the name if needed
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateaddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    // if (!value.contains('@')) {
    //   return 'Please enter a valid email address';
    // }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        Get.snackbar("Error", "Passwords do not match",
            backgroundColor: Colors.red);
        return; // Exit function if passwords don't match
      }
      try {
        EasyLoading.show(status: 'Please wait...');

        photoUrl = await StorageMethods().uploadImageToStorage(
          "profile",
          _image!,
        );
        _firebaseServices.Registration(
          _emailController,
          _passwordController,
          _nameController,
          imageid,
          photoUrl,
          context,
          address,
        );
        EasyLoading.showSuccess('Registration successful!...');
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
  }

  final bool _isLoading = false;
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Stack(
                        // alignment: AlignmentDirectional.topEnd,
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                  backgroundColor: Colors.red,
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage('${photoUrl}'),
                                  backgroundColor: Colors.red,
                                ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldInput(
                        validator: _validateName,
                        iconPath: "assets/email_perso.png",
                        hintText: 'Name',
                        textInputType: TextInputType.text,
                        textEditingController: _nameController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldInput(
                        validator: _validateEmail,
                        iconPath: "assets/email_perso.png",
                        hintText: 'Email',
                        textInputType: TextInputType.text,
                        textEditingController: _emailController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldInput(
                        validator: validateaddress,
                        iconPath: "assets/Location.png",
                        hintText: 'Adress',
                        textInputType: TextInputType.text,
                        textEditingController: address,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldInput(
                        validator: _validatePassword,
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
                        validator:
                            _validateConfirmPassword, // Use the new validation function

                        iconPath: "assets/lock.png",
                        hintText: 'Confirm Password',
                        textInputType: TextInputType.text,
                        textEditingController: _confirmPasswordController,
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
                            function: _handleRegistration,
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
