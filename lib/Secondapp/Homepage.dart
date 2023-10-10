import 'package:aimedscribble/checking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Constants/Constants.dart';
import 'Controller/SpeechController.dart';

class Sechomepage extends StatelessWidget {
  Sechomepage({Key? key});
  // TextEditingController _textController = TextEditingController();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: mainbody(controller, context),
                  ),
                ),
                bottom(controller),
                10.h.heightBox,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mainbody(SpeechController controller, BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,

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
          child: textformdata(controller, controller.transcription, context,
              labelText: Constants.labelText),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: textformdata(controller, controller.soapnotes, context,
              labelText: "Soap Notes"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: textformdata(controller, controller.vitalsController, context,
              labelText: "Vital signs"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: textformdata(controller, controller.cptController, context,
              labelText: "CPT Codes"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: textformdata(controller, controller.dxController, context,
              labelText: "DX Daignose"),
        ),
        // "SoapNotes".text.align(TextAlign.left).white.make()
      ],
    );
  }

  Widget bottom(SpeechController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconbutton(
              onpress: controller.startListening,
              icon: Icons.mic,
              colors:
                  controller.isListening ? Colors.greenAccent : Colors.white,
            ),
            SizedBox(width: 20.w),
            iconbutton(
              onpress: controller.stopListening,
              icon: Icons.stop,
            ),
            // SizedBox(width: 20.w),
            // iconbutton(
            //   onpress: controller.playText,
            //   icon: Icons.play_arrow,
            // ),
            SizedBox(width: 20.w),
            iconbutton(
              onpress: () {
                if (controller.soapnotes.text.isNotEmpty) {
                  controller.generatePDF();
                } else {
                  EasyLoading.showError("Not able to genrate empty pdf");
                }
              },
              icon: Icons.picture_as_pdf_rounded,
            ),
          ],
        ),
        10.h.heightBox,
        Container(
          // height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextButton(
            onPressed: () async {
              try {
                // ..customAnimation = CustomIndicator();

                String soapnotesprompt = """
              Generate SOAP (*Subjective, *Objective, *Assessment, *Plan) notes in short from the following conversation between a doctor and a patient:
              
              Note: Your ability to accurately capture and organize all this information in four main headings,

this is the four main Headings:

              *Subjective,

              *Objective,

              *Assessment,

              *Plan 



Conversation:
              ${controller.transcription.text.toString()}

              """;
                String vitalsprompt2 = """
                Extract the following information from this conversation:
              
                *Vital Signs:
                *Symptoms:
                *Medications:
                *Tests:
              
                Conversation: ${controller.transcription.text}
                
              """;

                String cptprompt3 =
                    """Given the conversation between a doctor and a patient, extract the relevant CPT codes based on the medical procedures discussed:
                              Conversation: ${controller.transcription.text} 

                              Extract the relevant CPT codes discussed in the conversation along with their corresponding short medical procedures.


""";
                String dXprompt4 =
                    """Given the conversation between a doctor and a patient, extract the relevant DX (diagnosis) codes based on the medical conditions discussed:

                              Conversation: ${controller.transcription.text} 

                              Extract the relevant DX codes discussed in the conversation along with their corresponding medical conditions.

""";
                EasyLoading.show(
                  status: 'Fetching SOAP notes...',
                );
                controller.soapnotes.text =
                    await getOpenAIResponse(soapnotesprompt);
// Step 2: Extract vital signs
                EasyLoading.show(
                  status: 'Fetching Vital Signs...',
                );
                controller.vitalsController.text =
                    await getOpenAIResponse(vitalsprompt2);
// Step 3: Extract CPT codes
                EasyLoading.show(
                  status: 'Fetching CPT codes...',
                );
                controller.cptController.text =
                    await getOpenAIResponse(cptprompt3);
// Step 4: Extract DX codes
                EasyLoading.show(
                  status: 'Fetching DX codes...',
                );
                controller.dxController.text =
                    await getOpenAIResponse(dXprompt4);

                EasyLoading.showSuccess(
                  'Complete',
                  maskType: EasyLoadingMaskType.custom,

                  // Define your custom success indicator here
                );
                controller.refresh();
              } catch (e) {
                EasyLoading.dismiss();
                print("Error: ${e}");

                // Show a user-friendly error message
                EasyLoading.showError(
                  "An error occurred while fetching data. Please try again later.",
                  duration: Duration(seconds: 2),
                );
              }
            },
            child: "Start Model".text.white.make(),
          ),
        ),
      ],
    );
  }

  TextFormField textformdata(
      SpeechController controller, textcontroller, context,
      {labelText = ""}) {
    return TextFormField(
      maxLines: null,
      controller: textcontroller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Constants.textColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.borderColor),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: textcontroller.text));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Text copied to clipboard')),
            );
          },
          child: Icon(Icons.content_copy, color: Constants.textColor),
        ),
      ),
      style: TextStyle(color: Constants.textColor),
    );
  }
}

Widget CustomIndicator() {
  return Center(
    child: Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color:
        //     Colors.transparent, // Set the background color to be transparent

        gradient: LinearGradient(
          colors: [
            Colors.cyan.withOpacity(0.3),
            Colors.cyan.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );
}

class iconbutton extends StatelessWidget {
  var onpress;

  IconData? icon;

  var colors;

  iconbutton({
    super.key,
    this.onpress,
    this.colors = Colors.white,
    this.icon = Icons.mic,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      // style: ElevatedButton.styleFrom(
      //   shape: CircleBorder(),
      //   padding: EdgeInsets.all(16),
      //   primary: Colors.transparent,
      //   elevation: 0,
      // ),
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),

          // shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF0D47A1)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: colors,
            size: 32,
          ),
        ),
      ),
    );
  }
}
