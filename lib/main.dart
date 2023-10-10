import 'package:aimedscribble/checking.dart';
import 'package:aimedscribble/screens/auth/login.dart';
import 'package:aimedscribble/screens/auth/sign_up.dart';
import 'package:aimedscribble/screens/welcome/welcome_screen.dart';
import 'package:aimedscribble/uitilities/FIrebaseServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:firebase_core/firebase_core.dart';
import 'Models/UserModel.dart';
import 'Secondapp/Homepage.dart';
import 'firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/dashboard/dashboard.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//yehi hai ab final baki sb khatam latest hai ye 18-august-2023
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configLoading();
  runApp(MyApp());
}

void configLoading() {
  // EasyLoading.instance
  //   ..loadingStyle = EasyLoadingStyle.custom
  //   ..indicatorType = EasyLoadingIndicatorType.fadingCircle
  //   ..maskColor = Colors.blue.withOpacity(0.5) // Adjust the opacity as needed
  //   ..backgroundColor =
  //       Colors.transparent // Set the background color to be transparent
  //   ..textColor = Colors.white
  //   ..maskType = EasyLoadingMaskType.custom;
  // EasyLoading.instance
  //   ..indicatorType = EasyLoadingIndicatorType
  //       .fadingCircle // Customize indicator type if needed
  //   ..loadingStyle = EasyLoadingStyle.custom // Set the loading style to custom
  //   ..indicatorColor = Colors.blue // Set the indicator color to blue
  //   ..backgroundColor = Colors.transparent // Set the background color
  //   ..textColor = Colors.blueAccent // Set the text color to blue
  //   ..maskColor = Colors.black.withOpacity(0.5);
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 10.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1200, 800), // Example web design size
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ai Med Scribble',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          builder: EasyLoading.init(),

          // Use the StreamBuilder to check the user's authentication status
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                // Check if the user is logged in
                if (snapshot.data != null) {
                  // Map<String, dynamic>? data = getUserData(snapshot.data!.uid);
                  // globaluserdata = UserModel.fromMap(data!);
                  // String uid = snapshot.data!.uid;

                  // CollectionReference usersCollection =
                  //     FirebaseFirestore.instance.collection('users');
                  // usersCollection
                  //     .doc(uid)
                  //     .get()
                  //     .then((DocumentSnapshot documentSnapshot) {
                  //   if (documentSnapshot.exists) {
                  //     // Convert the data to a Map
                  //     Map<String, dynamic> userData =
                  //         documentSnapshot.data() as Map<String, dynamic>;

                  //     // Create a UserModel from the retrieved data
                  //     UserModel user = UserModel.fromMap(userData);

                  //     // Assign the user to globaluserdata
                  //     globaluserdata = user;

                  //     print(globaluserdata!.address.toString());
                  //   }
                  // });

                  // User is logged in, navigate to Dashboard
                  return Sechomepage();

                  return Dashboard(
                      // userdata: globaluserdata,
                      ); // Replace with your Dashboard widget
                } else {
                  // User is not logged in, show the Login screen
                  return Sechomepage();
                }
              }
              // Show a loading indicator if the connection is not yet active
              return CircularProgressIndicator();
            },
          ),
        );
      },
    );
  }
}

Future<UserModel?> fetchUserData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (documentSnapshot.exists) {
      final userData = documentSnapshot.data() as Map<String, dynamic>;
      return UserModel.fromMap(userData);
    }
  }
  return null; // User not found or document doesn't exist
}
