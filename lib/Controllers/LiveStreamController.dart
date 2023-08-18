import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../uitilities/colors.dart';
import '../uitilities/utils.dart';

class LiveStreamController extends GetxController {
  stt.SpeechToText? speech;
  bool isListening = false;
  String recognizedText = '';
  String previousRecognizedText = '';

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
  }

  void startListening() async {
    recognizedText = '';
    if (!isListening) {
      bool available = await speech!.initialize(
        onStatus: (status) {
          if (status == stt.SpeechToText.listeningStatus) {
            isListening = true;
          } else {
            isListening = false;
          }
        },
        onError: (error) {
          showErrorSnackbar(error.errorMsg);
          isListening = false;
          Future.delayed(Duration(seconds: 1), () {
            if (!isListening) {
              startListening();
            }
          });
        },
      );

      if (available) {
        isListening = true;
        speech!.listen(
          listenFor: Duration(minutes: 10),
          onResult: (result) {
            recognizedText = "";
            for (final alternate in result.alternates) {
              recognizedText += alternate.recognizedWords + ' ';
            }
            update();
          },
        );
      }
    }
  }

  void stopListening() {
    if (isListening) {
      isListening = false;
      previousRecognizedText += recognizedText;
      speech!.stop();
      update();
    }
  }
}
