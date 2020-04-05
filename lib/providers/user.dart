import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants.dart' as Constants;

class User with ChangeNotifier {
  static const baseUrl = Constants.SERVER_IP+"/api/v1/";
  final storage = FlutterSecureStorage();

  final int user_id;
  final String email;
  String username;
  String about;
  String profile_image_url;
  bool is_following;
  int followerCount;
  int followingCount;

  User({
    @required this.user_id,
    @required this.username,
    @required this.profile_image_url,
    this.email,
    this.about,
    this.is_following,
    this.followerCount,
    this.followingCount,
  });

  Future<User> getProfile() async {
    // User user = User(user_id: 1, username: 'Ananya', profile_image_url: "lala");
    String url = baseUrl + "user";
    final token = await storage.read(key: "token");
    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      final responseJson = json.decode(response.body);
      final data = responseJson[0];
      User user = User(
        user_id: data["user_id"],
        username: data["username"],
        email: data["email"],
        about: data["about"],
        profile_image_url: data["profile_image_url"],
        followerCount: data["followercount"],
        followingCount: data["followingcount"],
      );
      return user;
    } catch (error) {
      throw error;
    }
  }

  void followUnfollow() {
    is_following = !is_following;
    notifyListeners();
  }
}
