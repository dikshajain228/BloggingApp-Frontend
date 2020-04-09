import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../server_util.dart' as Serverr;

class User with ChangeNotifier {
  static const baseUrl = Serverr.SERVER_IP + "/api/v1/";
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

  Future<int> changePassword(String oldPassword, String newPassword) async {
    String url = baseUrl + "user/password";
    final token = await storage.read(key: "token");
    print(oldPassword);
    print(newPassword);
    try {
      final response = await http.patch(
        url,
        body: {"oldPassword": oldPassword, "newPassword": newPassword},
        headers: {HttpHeaders.authorizationHeader: token},
      );
      int statusCode = response.statusCode;
      print("Status Code");
      print(statusCode);
      return statusCode;
    } catch (error) {
      throw error;
    }
  }

  Future<void> followUser(String userId) async {
    final token = await storage.read(key: "token");
    String url = baseUrl + "followers/" + userId;
    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      is_following = true;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> unfollowUser(String userId) async {
    final token = await storage.read(key: "token");
    String url = baseUrl + "followers/" + userId;
    try {
      final response = await http.delete(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      is_following = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void followUnfollow() {
    is_following = !is_following;
    notifyListeners();
  }
}
