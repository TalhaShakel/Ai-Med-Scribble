import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText? speech;
  bool isListening = false;
  String recognizedText = '';
  String previousRecognizedText = '';
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  void startListening() async {
    if (!isListening) {
      bool available = await speech!.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
          if (status == stt.SpeechToText.listeningStatus) {
            setState(() {
              isListening = true;
            });
          } else {
            print('Speech recognition status: $status');
            setState(() {
              isListening = false;
            });
            print('Speech listenContinuously start: $status');
            // startListening();
          }
        },
        onError: (error) {
          print('Speech recognition error: ${error}');
          showErrorSnackbar(error.errorMsg);
          setState(() {
            isListening = false;
          });
          Future.delayed(Duration(seconds: 1), () {
            if (!isListening) {
              startListening();
            }
          });
          // startListening(); // This line restarts listening after an error occurs.
        },
      );

      if (available) {
        print('Listening started...');
        setState(() {
          isListening = true;
        });

        speech!.listen(
          listenFor: Duration(minutes: 10),
          onResult: (result) {
            setState(() {
              recognizedText = "";
              for (final alternate in result.alternates) {
                recognizedText += alternate.recognizedWords + ' ';
              }
            });
          },
        );
      }
    }
  }

  void listenContinuously() {
    if (isListening) {
      speech!.listen(
        listenFor: Duration(minutes: 10),
        listenMode: stt.ListenMode.dictation,
        onResult: (result) {
          setState(() {
            recognizedText = "";

            for (final alternate in result.alternates) {
              recognizedText += alternate.recognizedWords + ' ';
            }
          });
        },
        cancelOnError: false,
      );
    }
  }

  void stopListening() {
    if (isListening) {
      print('Listening stopped.');
      setState(() {
        isListening = false;
        previousRecognizedText += recognizedText;
        textEditingController.text = previousRecognizedText;
      });
      speech!.stop();
    }
  }

  void clearText() {
    setState(() {
      recognizedText = '';
      previousRecognizedText = '';
      textEditingController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Speech to Text')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: textEditingController,
              onChanged: (text) {
                previousRecognizedText = text;
              },
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.left,
              readOnly: false,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Recognized Text',
              ),
            ),
            SizedBox(height: 20),
            Text(recognizedText),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isListening ? stopListening : startListening,
              child: Text(isListening ? 'Stop Listening' : 'Start Listening'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: clearText,
              child: Text('Clear Text'),
            ),
            SizedBox(height: 20),
            Text(
              isListening ? 'Listening...' : 'Not Listening',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void showErrorSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: Duration(seconds: 3),
  );
}