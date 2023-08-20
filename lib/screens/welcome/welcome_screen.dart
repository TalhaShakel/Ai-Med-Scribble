import 'package:aimedscribble/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../uitilities/colors.dart';
import '../../widgets/text_field_input.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 103.w,
                          height: 100.h,
                          child: RichText(
                              text: const TextSpan(
                                  text: "AI\n",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFBBC05)),
                                  children: [
                                TextSpan(
                                    text: "Medical\n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4285F4))),
                                TextSpan(
                                    text: "Scribe",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffFBBC05))),
                              ])),
                        ),
                        Container(
                          width: 115.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'English',
                                style: GoogleFonts.urbanist(
                                  fontSize: 18,
                                ),
                              ),
                              Image.asset("assets/container.png"),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 18.w),
                      child: RichText(
                          text: const TextSpan(
                              text: "Welcome",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4285F4),
                              ),
                              children: [
                            TextSpan(
                                text: " Back",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFBBC05))),
                            TextSpan(
                                text: " !",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffF000000))),
                          ])),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.w),
                      child: RichText(
                          text: const TextSpan(
                              text: "  Choose",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF000000),
                              ),
                              children: [
                            TextSpan(
                                text: " Your",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffF000000))),
                            TextSpan(
                                text: " Role",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4285F4))),
                          ])),
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.w, right: 20.w),
                          child: Container(
                            width: 155.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                                color: Color(0xffFBBC05).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Image.asset("assets/Avatarone.png"),
                                  ),
                                  Text(
                                    "Patient",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.w, right: 20.w),
                          child: Container(
                            width: 155.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                                color: Color(0xff4285F4).withOpacity(0.7),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Image.asset("assets/Avatartwo.png"),
                                  ),
                                  Text(
                                    "Doctor",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 12.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.w),
                          child: Container(
                            width: 155.w,
                            height: 330.h,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      child: Image.asset(
                                          "assets/Avatarthree.png")),
                                  Text(
                                    "Front Desk",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s,',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(35.0.w),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          width: 170.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff4285F4)),
                          child: Center(
                            child: Text(
                              "Let's get started!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
