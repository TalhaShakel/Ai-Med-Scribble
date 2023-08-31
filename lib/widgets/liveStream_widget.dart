import 'package:aimedscribble/checking.dart';
import 'package:aimedscribble/screens/dashboard/dashboard.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../uitilities/colors.dart';
import '../uitilities/aimodelservice.dart';

class LiveStreamWidget extends StatefulWidget {
  const LiveStreamWidget({super.key});

  @override
  State<LiveStreamWidget> createState() => _LiveStreamWidgetState();
}

class _LiveStreamWidgetState extends State<LiveStreamWidget> {
  stt.SpeechToText? speech;
  bool isListening = false;

  TextEditingController transcription = TextEditingController();
  String recognizedText = "";
  String previousRecognizedText = '';

  Color iconColor = Colors.black;
  Icon playIcon = const Icon(Icons.play_arrow);

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  void startListening() async {
    // Get.snackbar("Speech recognition status: $isListening", "");

    if (!isListening) {
      bool available = await speech!.initialize(
        onStatus: (status) {
          // Get.snackbar("Speech recognition status: $status", "");
          print('Speech recognition status: $status');
          if (status == stt.SpeechToText.listeningStatus) {
            isListening = true;
            // update();
          } else {
            isListening = false;
          }
        },
        onError: (error) {
          print('Speech recognition error: ${error}');
          // showErrorSnackbar(error.errorMsg);
          isListening = false;
          // update();
          Future.delayed(Duration(seconds: 1), () {
            if (!isListening) {
              startListening();
            }
          });
        },
      );

      if (available) {
        print('Listening started...');
        isListening = true;

        speech!.listen(
          listenFor: Duration(minutes: 10),
          onResult: (result) {
            setState(() {});
            recognizedText = "";
            for (final alternate in result.alternates) {
              recognizedText += alternate.recognizedWords + ' ';
            }
          },
        );
      }
    }
    setState(() {});
  }

  void _stopListening() async {
    if (isListening) {
      print('Listening stopped.');
      isListening = false;
      previousRecognizedText += recognizedText;
      transcription.text = previousRecognizedText;
      // update();
      speech!.stop();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Card(
            //     elevation: 20,
            //     color: Colors.white,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: SizedBox(
            //         width: screenWidth * 0.5,
            //         height: 450,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 80,
            //               width: screenWidth,
            //               decoration: const BoxDecoration(
            //                   color: blueColor,
            //                   borderRadius: BorderRadius.only(
            //                       topLeft: Radius.circular(10),
            //                       topRight: Radius.circular(10))),
            //               child: Padding(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: screenWidth * 0.02),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Image.asset("assets/video.png"),
            //                         const SizedBox(
            //                           width: 20,
            //                         ),
            //                         const Text(
            //                           "Live Stream",
            //                           style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 15,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Image.asset("assets/arrow _down.png"),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Expanded(
            //                 child: Image.asset(
            //               "assets/bgImage.png",
            //               fit: BoxFit.cover,
            //             )),
            //             Container(
            //               height: 80,
            //               width: screenWidth,
            //               alignment: Alignment.center,
            //               decoration: const BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(10),
            //                       bottomRight: Radius.circular(10))),
            //               child: const Text(
            //                 "Live Stream",
            //                 style: TextStyle(
            //                   color: text2Color,
            //                   fontSize: 15,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ))),

            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 20,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                  width: screenWidth * 0.5,
                  height: 200,
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: screenWidth,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          child: Row(
                            children: [
                              Image.asset("assets/message.png"),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Messenger",
                                style: TextStyle(
                                  color: text2Color,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Send Doctor a message....",
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),

            Card(
              elevation: 20,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: screenWidth,
                        decoration: const BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Speech to Text",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              AvatarGlow(
                                animate: isListening,
                                glowColor: Colors.blue.shade200,
                                duration: const Duration(milliseconds: 2000),
                                repeatPauseDuration:
                                    const Duration(milliseconds: 100),
                                repeat: true,
                                endRadius: 25.0,
                                child: IconButton(
                                    onPressed: isListening
                                        ? _stopListening
                                        : startListening,
                                    icon: Icon(isListening
                                        ? Icons.mic
                                        : Icons.mic_off)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      try {
                                        //                                         String prompt =
                                        //                                             """
                                        // generate soap notes of this conversation which is between doctor and patient
                                        //            conversation: ${transcription.text}
                                        //            """;
                                        String prompt = """
                Generate SOAP (Subjective, Objective, Assessment, Plan) notes along with relevant CPT (Current Procedural Terminology) codes based on the provided conversation between a doctor and a patient:
                
                *Conversation:
                ${transcription.text}
              
                Your ability to accurately capture and organize this information, including CPT codes, will determine the quality of the generated SOAP notes and ensure proper billing and coding for medical services.
                """;
                                        print("Transcription Text: " +
                                            transcription.text);

                                        String prompt2 = """
                  Extract the following information from this conversation:
                
                  *Vital Signs:
                  *Symptoms:
                  *Medications:
                  *Tests:
                
                  Conversation: ${transcription.text}
                  
                """;
                                        print("Prompt2: " + prompt2);

                                        String prompt3 =
                                            """Given the conversation between a doctor and a patient, extract the relevant CPT codes based on the medical procedures discussed:
                                Conversation: ${transcription.text} 

                                Extract the relevant CPT codes discussed in the conversation along with their corresponding short medical procedures.

""";
                                        String prompt4 =
                                            """Given the conversation between a doctor and a patient, extract the relevant DX (diagnosis) codes based on the medical conditions discussed:

                                Conversation: ${transcription.text} 

                                Extract the relevant DX codes discussed in the conversation along with their corresponding medical conditions.

""";
                                        EasyLoading.show(
                                            status:
                                                "Fetching data 60 seconds wait...");
                                        // Get.snackbar("Fetching soap notes...",
                                        //     "Please wait...");

                                        List<Chat> chatList =
                                            await submitGetChatsForm(
                                          context: context,
                                          prompt: prompt,
                                          tokenValue: 100,
                                        );
                                        print("soap notes:" +
                                            chatList.toString());

                                        // Get.snackbar("Fetching vital signs...",
                                        //     "Please wait...");
                                        await Future.delayed(
                                            Duration(seconds: 20));

                                        List<Chat> chatList2 =
                                            await submitGetChatsForm(
                                          context: context,
                                          prompt: prompt2,
                                          tokenValue: 100,
                                        );
                                        print("vital signs:" +
                                            chatList2.toString());
                                        await Future.delayed(
                                            Duration(seconds: 20));

                                        List<Chat> chatList3 =
                                            await submitGetChatsForm(
                                          context: context,
                                          prompt: prompt3,
                                          tokenValue: 100,
                                        );
                                        print("CPT Codes:" +
                                            chatList3.toString());
                                        await Future.delayed(
                                            Duration(seconds: 20));

                                        List<Chat> chatList4 =
                                            await submitGetChatsForm(
                                          context: context,
                                          prompt: prompt4,
                                          tokenValue: 100,
                                        );
                                        print(
                                            "DX Codes:" + chatList4.toString());

                                        GlobalVariables.updateOutput(chatList
                                            .map((e) => e.msg)
                                            .toList());
                                        GlobalVariables.updateOutput2(chatList2
                                            .map((e) => e.msg)
                                            .toList());
                                        GlobalVariables.updateOutput3(chatList3
                                            .map((e) => e.msg)
                                            .toList());
                                        GlobalVariables.updateOutput4(chatList4
                                            .map((e) => e.msg)
                                            .toList());
                                        // Get.snackbar(
                                        //     "Updating UI...", "Please wait...");
                                        Get.offAll(() => Dashboard());

                                        setState(() {});
                                        EasyLoading.showSuccess(
                                            "Data has been updated successfully");

                                        // Get.snackbar("Update complete",
                                        //     "Data has been updated successfully");
                                      } catch (e) {
                                        print("An error occurred: $e");
                                        Get.snackbar("An error occurred",
                                            "Please try again",
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            duration: Duration(seconds: 3));
                                      }
                                    },
                                    child:
                                        Image.asset("assets/solar_hambur.png")),
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset("assets/replayrounded.png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/play-arrow-rounded.png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/forwardrounded.png"),
                              ],
                            ),
                            Image.asset("assets/volume-up-fill.png"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Text(speech!.isListening == true
                            ? recognizedText
                            : isListening
                                ? recognizedText
                                : 'Tap the microphone to start listening...'),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child:
                              // Wrap(
                              //   spacing: 8.0,
                              //   runSpacing: 8.0,
                              //   children: previousRecognizedText
                              //       .map((item) =>
                              TextFormField(
                            maxLength: null, maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Dr and patient Speech to text",
                            ),
                            // readOnly: true,
                            controller: transcription,
                          )
                          // )
                          // .toList(),
                          // ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlobalVariables {
  static List<String> output2 = [];
  static List<String> output = [];
  static List<String> output3 = [];
  static List<String> output4 = [];

  static void updateOutput(List<String> newData) {
    output = newData;
    print("output" + newData.toString());
  }

  static void updateOutput2(List<String> newData) {
    output2 = newData;
    print("output2" + newData.toString());
  }

  static void updateOutput3(List<String> newData) {
    output3 = newData;
    print("output3" + newData.toString());
  }

  static void updateOutput4(List<String> newData) {
    output4 = newData;
    print("output3" + newData.toString());
  }
}
