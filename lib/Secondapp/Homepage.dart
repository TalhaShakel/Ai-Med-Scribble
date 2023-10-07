import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Constants/Constants.dart';
import 'Controller/SpeechController.dart';

class Sechomepage extends StatelessWidget {
  Sechomepage({Key? key});
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpeechController>(
      init: SpeechController(), // Initialize the controller
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.2,
                colorFilter:
                    ColorFilter.mode(Constants.primaryColor, BlendMode.overlay),
                fit: BoxFit.cover,
                image: AssetImage(Constants.backgroundImage),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  10.heightBox,
                  Image.asset(
                    "assets/logo-no-background.png",
                    height: 100.h,
                  ),
                  30.heightBox,

                  "${controller.speech?.isListening == true ? controller.recognizedText : controller.isListening ? controller.recognizedText : 'Tap the microphone to start listening...'}"
                      .text
                      .size(21)
                      .white
                      .make(),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  //   child: Text(controller.speech?.isListening == true
                  //       ? controller.recognizedText
                  //       : controller.isListening
                  //           ? controller.recognizedText
                  //           : 'Tap the microphone to start listening...'),
                  // ),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: Constants.labelText,
                        labelStyle: TextStyle(color: Constants.textColor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Constants.borderColor),
                        ),
                      ),
                      style: TextStyle(color: Constants.textColor),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: controller.startListening,
                        child: Icon(Icons.mic),
                      ),
                      SizedBox(width: 20.w),
                      ElevatedButton(
                        onPressed: controller.stopListening,
                        child: Icon(Icons.stop),
                      ),
                      SizedBox(width: 20.w),
                      ElevatedButton(
                        onPressed: controller.playText,
                        child: Icon(Icons.play_arrow),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
