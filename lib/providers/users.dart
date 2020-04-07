import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './user.dart';

import '../server_util.dart' as Server;

class Users with ChangeNotifier {
  static const baseUrl = Server.SERVER_IP + "/api/v1/";
  final storage = FlutterSecureStorage();

  List<User> _users = [];

  List<User> get users {
    return [..._users];
  }

  Future<User> fetchUserById(String userId) async{
    print("what is the about error");
    final token = await storage.read(key: "token");
    String url = baseUrl + "users/" + userId;
    print("check"+url);
    try{
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print("whats rge provlem");
      final responseJson = json.decode(response.body);
      print(responseJson);
      print("jajaja");
      final userData = responseJson[0];
      print(userData);
      print("mynamyna");
      print(userData["about"]+"please bro");
      User user = User(
        username: userData["username"],
        user_id: userData["user_id"],
        email: userData["email"],
        about: userData["about"],
        profile_image_url: userData["profile_image_url"],
        followerCount: userData["followercount"],
        followingCount: userData["followingcount"],
        is_following: userData["is_following"] == 0 ? false:true,


      );
      return user;
    }catch(error){
      throw error;
    }
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

  Future<void> searchUsers(String query) async {
    List<User> fetchedUsers = [];
    final token = await storage.read(key: "token");
    final user_id = await storage.read(key: "user_id");
    String base = Server.base;
    String path = "/api/v1/users";
    var queryParams = {"q": query};
    var url = Uri.http(base, path, queryParams);
    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print(response.body);
      print("hello kitty" + url.toString());
      final responseJson = json.decode(response.body);
      for (final user in responseJson) {
        fetchedUsers.add(User(
          user_id: user["user_id"],
          email: user["email"],
          username: user["username"],
          profile_image_url: user["profile_image_url"],
          is_following: user["is_following"] == 0 ? false : true,
        ));
      }
      _users = [...fetchedUsers];
    } catch (error) {
      throw error;
    }
  }
}
