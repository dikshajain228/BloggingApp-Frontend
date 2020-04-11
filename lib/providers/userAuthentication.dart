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
  String _username, _email, _profile_image_url;

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
        String token = resJson["token"];
        final tokenPayload = token.split(".");
        final payloadMap = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(tokenPayload[1]))));
        _username = payloadMap["username"];
        _email = payloadMap["email"];
        _profile_image_url = payloadMap["profile_image_url"];
        print("obtained token" + token);
        return token;
      }
      return null;
    } catch (error) {
      throw error;
    }
  }

  String getUsername(){
    return _username;
  }

  String getEmail(){
    return _email;
  }

  String getProfileImage(){
    return _profile_image_url;
  }
}
