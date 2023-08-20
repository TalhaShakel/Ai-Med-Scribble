import 'package:aimedscribble/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/UserModel.dart';
import '../screens/dashboard/dashboard.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
  ) async {
    try {
      EasyLoading.show(status: 'Please wait...');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Successful sign-in, navigate to the Dashboard or perform desired actions
      // Get.snackbar("Success", "Successful sign-in",
      //     backgroundColor: Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
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
      Get.snackbar("Error", errorMessage, backgroundColor: Colors.red);
    }
  }

  void Registration(
    TextEditingController emailController,
    TextEditingController passwordController,
    name,
    BuildContext context,
  ) async {
    try {
      EasyLoading.show(status: 'Please wait...');

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: emailController.text,
        displayName: name.text,
        profileImageURL:
            'https://example.com/profile.jpg', // Default profile image URL
        password: passwordController
            .text, // Store password securely, this is just an example
      );

      await saveUserData(user.uid, user);
      // Registration successful, navigate to the Login screen or perform desired actions
      EasyLoading.showSuccess('Registration successful!...');

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
      Get.snackbar("Error", errorMessage, backgroundColor: Colors.red);
    }
  }
}
