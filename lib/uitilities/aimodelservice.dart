import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

String OPEN_API_KEY = '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';
String BASE_URL = 'https://api.openai.com/v1/';
Future<List<Chat>> submitGetChatsForm({
  required BuildContext context,
  required String prompt,
  required int tokenValue,
  String? model,
  String? outputLanguageCode,
}) async {
  print("Entering submitGetChatsForm function");

  NetworkClient networkClient = NetworkClient();
  List<Chat> chatList = [];
  try {
    final res = await networkClient.post(
      "${BASE_URL}completions",
      {
        "model": "text-davinci-002",
        "prompt": prompt,
        "temperature": 0,
        "max_tokens": 100,
      },
      token: OPEN_API_KEY,
    );
    Map<String, dynamic> mp = jsonDecode(res.toString());
    print("Response: ${mp.toString()}");
    if (mp['choices'] != null && mp['choices'].length > 0) {
      chatList = List.generate(mp['choices'].length, (i) {
        return Chat.fromJson(<String, dynamic>{
          'msg': mp['choices'][i]['text'],
          'chat': 1,
        });
      });
      print("Chat List: ${chatList.toString()}");
    }
  } on RemoteException catch (e) {
    print("Error occurred: ${e.toString()}");
  }

  print("Exiting submitGetChatsForm function");
  return chatList;
}

class Chat {
  final String msg;
  final int chat;
  Chat({
    required this.msg,
    required this.chat,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        chat: json['chat'],
        msg: json['msg'],
      );

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'chat': chat,
    };
  }
}

class NetworkClient {
  Dio _dio = Dio();
  NetworkClient({String? baseUrl}) {
    baseUrl ??= "";
    BaseOptions baseOptions = BaseOptions(
      // receiveTimeout: 20000,
      // connectTimeout: 30000,
      baseUrl: baseUrl,
      maxRedirects: 2,
    );
    _dio = Dio(baseOptions);
    // adding logging interceptor.
    _dio.interceptors.add(LogInterceptor(
      requestBody: false,
      error: true,
      request: false,
      requestHeader: false,
      responseBody: true,
      responseHeader: false,
    ));
  }

  // for HTTP.GET Request.
  Future<Response> get(String url,
      {Map<String, dynamic>? params, String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) map.addAll({"Authorization": "Bearer $token"});

      response = await _dio.get(url,
          queryParameters: params,
          options: Options(
            headers: map,
          ));
    } on DioError catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  // for HTTP.POST Request.
  Future<Response> post(String url, Map<String, dynamic> params,
      {String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) {
        map.addAll({"Authorization": "Bearer $token"});
      }
      response = await _dio.post(url,
          data: params,
          options: Options(
            headers: map,
            responseType: ResponseType.json,
            validateStatus: (_) => true,
          ));
    } on DioError catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  // for HTTP.POST Request.
  Future<Response> put(String url, Map<String, dynamic> params,
      {String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) {
        map.addAll({"Authorization": "Bearer $token"});
      }
      response = await _dio.put(url,
          data: params,
          options: Options(
            headers: map,
            responseType: ResponseType.json,
            validateStatus: (_) => true,
          ));
    } on DioError catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  // for HTTP.PATCH Request.
  Future<Response> patch(String url, Map<String, Object> params) async {
    Response response;
    try {
      response = await _dio.patch(url,
          data: params,
          options: Options(
            responseType: ResponseType.json,
          ));
    } on DioError catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  // for download Request.
  Future<Response> download(String url, String pathName,
      void Function(int, int)? onReceiveProgress) async {
    Response response;
    try {
      response = await _dio.download(
        url,
        pathName,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }

  // for fileUpload Request.
  Future<Response> fileUpload(String url, FormData params) async {
    Response response;
    try {
      response = await _dio.post(url,
          data: params,
          options: Options(
            responseType: ResponseType.json,
          ));
    } on DioError catch (exception) {
      throw RemoteException(dioError: exception);
    }
    return response;
  }
}

// Represent exceptions from Server/Remote data source.
class RemoteException implements Exception {
  DioError dioError;

  RemoteException({required this.dioError});
}

// Represent exceptions from Cache.
class LocalException implements Exception {
  String error;

  LocalException(this.error);
}

class RouteException implements Exception {
  final String message;
  RouteException(this.message);
}
