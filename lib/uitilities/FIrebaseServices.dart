import 'package:aimedscribble/screens/auth/login.dart';
import 'package:aimedscribble/uitilities/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserModel.dart';
import '../screens/dashboard/dashboard.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class FirebaseServices {
  updateUserData(String uid, data) async {
    try {
      EasyLoading.show(status: 'Please wait...');

      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      await userRef.update(data);
      EasyLoading.showSuccess("Data updated successfully");

      print('Data updated successfully for user with UID: $uid');
    } catch (error) {
      EasyLoading.dismiss();
      print('Error updating data for user with UID: $uid - $error');
    }
  }

  Future<void> saveUserData(String? uid, data) async {
    try {
      if (uid != null && uid.isNotEmpty) {
        await _firestore.collection('users').doc(uid).set(data);
        print('User data saved to Firestore');
      } else {
        await _firestore.collection('users').add(data);
        print('User data added to Firestore');
      }
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<void> login(
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
    String imagevalue,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait...');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Map<String, dynamic>? data = await getUserData(userCredential.user!.uid);
      globaluserdata = UserModel.fromMap(data!);
      print(globaluserdata!.email.toString());
      imagevalue = globaluserdata!.profileImageURL;

      // Successful sign-in, navigate to the Dashboard or perform desired actions
      // Get.snackbar("Success", "Successful sign-in",
      //     backgroundColor: Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(
              // userdata: globaluserdata!
              ),
        ),
      );
      EasyLoading.showSuccess("Successful sign-in");
    } catch (e) {
      EasyLoading.dismiss();
      // Handle sign-in errors, show error message
      String errorMessage = "An error occurred. Please try again later.";
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      print('Error Still:: $errorMessage');
      Get.snackbar("Error", errorMessage, backgroundColor: Colors.red);
    }
  }

  void Registration(
    TextEditingController emailController,
    TextEditingController passwordController,
    name,
    imageid,
    String profileImageURL,
    BuildContext context,
    TextEditingController address,
  ) async {
    try {
      print("start user registeration");

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      print("complete user registeration");
      print('Address: $address');
      print('Image ID: $imageid');
      print('UID: ${userCredential.user!.uid}');
      print('Email: ${emailController.text}');
      print('Display Name: ${name.text}');
      print('Profile Image URL: $profileImageURL'); // Default profile image URL
      print('Password: ${passwordController.text}');
      UserModel user = UserModel(
        address: address.text,
        imageid: imageid,
        uid: userCredential.user!.uid,
        email: emailController.text,
        displayName: name.text,
        profileImageURL: profileImageURL, // Default profile image URL
        password: passwordController
            .text, // Store password securely, this is just an example
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
      print('User Model Information:');
      print('Address: ${user.address}');
      print('Image ID: ${user.imageid}');
      print('UID: ${user.uid}');
      print('Email: ${user.email}');
      print('Display Name: ${user.displayName}');
      print('Profile Image URL: ${user.profileImageURL}');
      print('Password: ${user.password}');
      print("store user datar");

      await saveUserData(user.uid, user.toMap());
      // Registration successful, navigate to the Login screen or perform desired actions

      // Get.snackbar("Success", "Registration successful!",
      //     backgroundColor: Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } catch (e) {
      // Handle registration errors, show error message
      String errorMessage = "An error occurred. Please try again later.";
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      print('Error Still:: $errorMessage');
      // Get.snackbar("Error", errorMessage, backgroundColor: Colors.red);
    }
  }
}

getUserData(String? uid) async {
  try {
    if (uid != null && uid.isNotEmpty) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        // User document does not exist
        return null;
      }
    } else {
      // Invalid UID
      return null;
    }
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}
