import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../server_util.dart' as Server;

class Login with ChangeNotifier {
  static const SERVER_IP = Server.SERVER_IP;
  final storage = FlutterSecureStorage();

  Future<int> attemptSignUp(
      String email, String password, String username) async {
    try {
      var res = await http.post("$SERVER_IP/api/v1/signup",
          body: {"email": email, "password": password, "username": username, "about":"", "profile_image_url":"" },
      );
      if(res.statusCode==409){
        return 409;
      }
      else if(res.statusCode==200){
        return 200;
      }
      else{
        return 400;
      }
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
      print(Server.SERVER_IP + "jajajaja");
      print("Length" + resJson.length.toString());
      print(resJson);
      if (resJson.length == 1) {
        return null;
      }
      return resJson["token"];
    } catch (error) {
      throw error;
    }
  }
}
