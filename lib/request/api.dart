import 'dart:convert';

import 'package:agri_food_freind/request/data.dart';
import 'package:http/http.dart' as http;

class API {
  final client = http.Client();

  final header = {
    'Content-Type': 'application/json',
  };
  final String domain = "https://e59b-211-21-101-144.ngrok-free.app";
  // final String domain="https://argi-food.onrender.com";
  Future<Format> lunch(Future<http.Response> function) async {
    Map responseBody = {"D": {}, "message": "error", "success": false};

    await function.then((response) {
      responseBody = json.decode(utf8.decode(response.bodyBytes));
    }).catchError((err) {});

    return Format.fromJson(responseBody);
  }
}
