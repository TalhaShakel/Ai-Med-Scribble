import 'dart:convert';
import 'package:aimedscribble/Secondapp/secrets.dart';
import 'package:aimedscribble/uitilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'openai_service.dart';

class ChatGPTTest extends GetWidget {
  TextEditingController transcription = TextEditingController();

  final responseText = ''.obs;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('OpenAI Flutter Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: transcription,
                ),
                ElevatedButton(
                  onPressed: () {
                    // getOpenAIResponse,
                  },
                  child: Text('Get OpenAI Response'),
                ),
                SizedBox(height: 20),
                Obx(() => Text(responseText.value)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getOpenAIResponse( prompt) async {
  try {
   
    final OpenAIService openaiService = OpenAIService("$apikey");

    String response = await openaiService.getResponse("$prompt");
    print(response);
    // transcription.text = response;
    return response;
  } catch (e) {
    print(e.toString());
  }
}

class OpenAIService {
  final String apiKey;

  OpenAIService(this.apiKey);

  Future<String> getResponse(String userMessage) async {
    try {
      print('Sending request to OpenAI API...');
      var url = Uri.parse('https://api.openai.com/v1/chat/completions');
      var headers = {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      };

      var requestBody = jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "Hello, ChatGPT!"},
          {"role": "user", "content": userMessage},
        ],
      });

      print('Request Body: $requestBody');

      var response = await http.post(url, headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        print('Response received from OpenAI API.');
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['choices'][0]['message']['content'];
      } else {
        print(
            'Error response from OpenAI API. Status Code: ${response.statusCode}');
        throw Exception('Failed to get response from OpenAI API');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error in getting response from OpenAI API');
    }
  }
}
