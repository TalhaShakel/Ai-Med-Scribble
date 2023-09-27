import 'dart:typed_data';

import 'package:aimedscribble/Models/UserModel.dart';
import 'package:aimedscribble/screens/auth/login.dart';
import 'package:aimedscribble/screens/dashboard/dashboard.dart';
import 'package:aimedscribble/uitilities/contant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../uitilities/FIrebaseServices.dart';
import '../../uitilities/colors.dart';
import '../../uitilities/utils.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/auth_icon_button.dart';
import '../../widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

import '../welcome/welcome_screen.dart';

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
      "https://static.vecteezy.com/system/resources/previews/005/520/145/original/cartoon-drawing-of-a-doctor-vector.jpg";

  selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    if (im != null) {
      // Set state because we need to display the image we selected on the circle avatar
      setState(() {
        _image = im;
      });
      photoUrl = await StorageMethods().uploadImageToStorage(
        "profile",
        _image!,
      );
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
                      height: 20,
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: "Profile".text.make(),
                      trailing: Image.asset(
                        "$applogo",
                        height: 100.h,
                      ),
                      leading: IconButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Get.offAll(() => Dashboard());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [],
                    // ),
                    // const SizedBox(
                    //   height: 50,
                    // ),

                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text(
                    //     " Profile",
                    //     style: TextStyle(
                    //         color: textColor,
                    //         fontSize: 25,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
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
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => WelcomeScreen());
                        },
                        child: Text("LogOut")),
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
                          text: 'Update',
                          function: () async {
                            globaluserdata?.displayName = _nameController.text;
                            globaluserdata?.address = address.text;

                            FirebaseServices().updateUserData(
                                globaluserdata!.uid, {
                              "displayName": _nameController.text,
                              "address": address.text
                            });
                            Map<String, dynamic>? data =
                                await getUserData(globaluserdata!.uid);
                            globaluserdata = UserModel.fromMap(data!);
                            setState(() {});
                          },
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
