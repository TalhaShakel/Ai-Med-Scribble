import 'package:aimedscribble/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:firebase_core/firebase_core.dart';
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
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType
        .fadingCircle // Customize indicator type if needed
    ..loadingStyle = EasyLoadingStyle.custom // Set the loading style to custom
    ..indicatorColor = Colors.blue // Set the indicator color to blue
    ..backgroundColor = Colors.transparent // Set the background color
    ..textColor = Colors.blueAccent // Set the text color to blue
    ..maskColor = Colors.black.withOpacity(0.5);
  // EasyLoading.instance
  //   ..displayDuration = const Duration(milliseconds: 2000)
  //   ..indicatorType = EasyLoadingIndicatorType.fadingCircle
  //   ..loadingStyle = EasyLoadingStyle.dark
  //   ..indicatorSize = 45.0
  //   ..radius = 10.0
  //   ..progressColor = Colors.yellow
  //   ..backgroundColor = Colors.green
  //   ..indicatorColor = Colors.yellow
  //   ..textColor = Colors.yellow
  //   ..maskColor = Colors.blue.withOpacity(0.5)
  //   ..userInteractions = true
  //   ..dismissOnTap = false
  //   ..customAnimation = CustomAnimation();
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
                  // User is logged in, navigate to Dashboard
                  return Dashboard(); // Replace with your Dashboard widget
                } else {
                  // User is not logged in, show the Login screen
                  return Login();
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
