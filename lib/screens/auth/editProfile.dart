import 'dart:typed_data';

import 'package:aimedscribble/Models/UserModel.dart';
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

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _SignUpState();
}

class _SignUpState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = globaluserdata!.displayName;
    _emailController.text = globaluserdata!.email;
    address.text = globaluserdata!.address;
    _passwordController.text = globaluserdata!.password;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Edit Profile",
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
                                backgroundImage: NetworkImage(
                                    globaluserdata!.profileImageURL),
                                // backgroundImage: NetworkImage('${photoUrl}'),
                                backgroundColor: Colors.grey,
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
                      iconPath: "assets/Location.png",
                      hintText: 'Adress',
                      textInputType: TextInputType.text,
                      textEditingController: address,
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
                    SizedBox(
                        height: 60,
                        width: screenWidth,
                        child: AuthButton(
                          backgroundColor: blueColor,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          text: 'Submit',
                          function: () {},
                        )),
                    const SizedBox(
                      height: 40,
                    ),
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
