import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './user.dart';

class Users with ChangeNotifier {
  static const baseUrl = "http://10.0.2.2:3000/api/v1/";
  final storage = FlutterSecureStorage();

  List<User> _users = [];

  List<User> get users {
    return [..._users];
  }

// Update user profile
  Future<void> updateProfile(Map<String, dynamic> data, File image) async {
    print(data);
    final token = await storage.read(key: "token");

    String url = baseUrl + "user";

    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers["Authorization"] = token;

    if (image != null) {
      String filename = image.path;
      print(filename);
      request.files.add(await http.MultipartFile.fromPath('image', filename));
    }
    request.fields["username"] = data["username"];
    request.fields["about"] = data["about"];
    request.fields["profile_image_url"] = data["imageUrl"];

    try {
      final response = await request.send();
      print(response);
    } catch (error) {
      throw error;
    }
  }

  User getUserProfile() {
    return User(
        user_id: 1,
        is_following: false,
        email: "nairanjali0508@gmail.com",
        username: "anjalay",
        about:
            "HElo gurls nd bois ssup with y'all. How is corona treating you? Hope all are infected",
        profile_image_url:
            "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk");
  }
}
