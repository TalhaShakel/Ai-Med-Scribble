import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechController extends GetxController {
  TextEditingController transcription = TextEditingController();
  stt.SpeechToText? speech = stt.SpeechToText();
  bool isListening = false;
  int autoListenStart = 0;
  String recognizedText = "";
  String previousRecognizedText = "";

  void startListening() async {
    // Get.snackbar("Speech recognition status: $isListening", "");
    autoListenStart++;
    print(autoListenStart);
    if (speech == null) {
      speech = stt.SpeechToText();
    }

    if (!isListening) {
      bool available = await speech!.initialize(
        onStatus: (status) {
          // Get.snackbar("Speech recognition status: $status", "");
          print('Speech recognition status: $status');
          if (status == stt.SpeechToText.listeningStatus) {
            // autoListenStart++;

            isListening = true;
            update(); // Notify the UI to rebuild
          } else if (status == stt.SpeechToText.notListeningStatus) {
            if (autoListenStart > 0) {
              autoListenStart++;
              // previousRecognizedText += recognizedText;
              // transcription.text = previousRecognizedText;
              stopListening();
              Future.delayed(Duration(seconds: 2), () {
                if (!isListening) {
                  startListening();
                }
              });
              print(" autoListenStart != 0:    $autoListenStart");
            }

            // startListening();
          } else {
            stopListening();
          }
        },
        onError: (error) {
          // showErrorSnackbar(error.errorMsg);
          isListening = false;
          // update();
          stopListening();

          Future.delayed(Duration(seconds: 2), () {
            if (!isListening) {
              startListening();
            }
          });
          print('Speech recognition error: ${error}');
        },
      );

      if (available) {
        print('Listening started...');
        isListening = true;

        speech!.listen(
          // cancelOnError: false,
          // pauseFor: Duration(minutes: 1),
          listenFor: Duration(minutes: 100),
          onResult: (result) {
            recognizedText = "";
            for (final alternate in result.alternates) {
              recognizedText += alternate.recognizedWords + ' ';
            }
            print(recognizedText);
            update(); // Notify the UI to rebuild
          },
        );
      }
    }
    update(); // Notify the UI to rebuild
  }

  // void startListening() async {
  //   autoListenStart++;
  //   print(autoListenStart);

  //   if (!isListening) {
  //     bool available = await speech!.initialize(
  //       onStatus: (status) {
  //         print('Speech recognition status: $status');
  //         if (status == stt.SpeechToText.listeningStatus) {
  //           isListening = true;
  //           update(); // Notify the UI to rebuild
  //         } else if (status == stt.SpeechToText.notListeningStatus) {
  //           if (autoListenStart > 0) {
  //             autoListenStart++;
  //             stopListening();
  //             Future.delayed(Duration(seconds: 2), () {
  //               if (!isListening) {
  //                 startListening();
  //               }
  //             });
  //             print(" autoListenStart != 0:    $autoListenStart");
  //           }
  //         } else {
  //           stopListening();
  //         }
  //       },
  //       onError: (error) {
  //         isListening = false;
  //         stopListening();

  //         Future.delayed(Duration(seconds: 2), () {
  //           if (!isListening) {
  //             startListening();
  //           }
  //         });
  //         print('Speech recognition error: ${error}');
  //       },
  //     );

  //     if (available) {
  //       print('Listening started...');
  //       isListening = true;

  //       speech!.listen(
  //         listenFor: Duration(minutes: 100),
  //         onResult: (result) {
  //           recognizedText = "";
  //           for (final alternate in result.alternates) {
  //             recognizedText += alternate.recognizedWords + ' ';
  //           }
  //           update(); // Notify the UI to rebuild
  //         },
  //       );
  //     }
  //   }
  // }

  void stopListening() async {
    if (isListening) {
      autoListenStart = 0;
      update(); // Notify the UI to rebuild

      if (autoListenStart == 0) {
        print('Listening stopped.');
        isListening = false;
        print(recognizedText);
        previousRecognizedText += recognizedText;
        transcription.text = previousRecognizedText;
        speech!.stop();
        update(); // Notify the UI to rebuild
      }
    }
  }

  void playText() {
    // Add logic to play the recognized text
  }
}
