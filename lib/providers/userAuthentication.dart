import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../server_util.dart' as Server;

class Authentication with ChangeNotifier {
  static const SERVER_IP = Server.SERVER_IP;
  final storage = FlutterSecureStorage();

  Future<int> attemptSignUp(
      String email, String password, String username) async {
    try {
      var res = await http.post("$SERVER_IP/api/v1/signup",
          body: {"email": email, "password": password, "username": username, "about":"", "profile_image_url":"" },
      );
      return res.statusCode;
    } catch (error) {
      throw error;
    }
  }

  Future<String> attemptLogin(String email, String password) async {
    try {
      var res = await http.post(
        "$SERVER_IP/api/v1/login",
        body: {"email": email, "password": password},
      );
      final resJson = json.decode(res.body);
      if (res.statusCode==200) {
        return resJson["token"];
      }
      return null;
    } catch (error) {
      throw error;
    }
  }
}
