import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart' as Constants;

class Collection with ChangeNotifier {
  final String collection_id;
  final int user_id;
  String collection_name;
  String image_url;
  String description;
  bool user_only; //Will be removed
  bool is_owner;
  bool is_author;
  bool is_following;
  List<dynamic> authors;

  static const baseUrl = Constants.SERVER_IP + "api/v1/";
  final storage = FlutterSecureStorage();

  Collection({
    @required this.collection_id,
    @required this.user_id,
    @required this.collection_name,
    this.image_url,
    this.description,
    this.user_only,
    this.is_owner,
    this.is_author,
    this.is_following,
    this.authors,
  });

  // Follow collection
  Future<void> followCollection(String collectionId) async {
    final token = await storage.read(key: "token");
    String url = baseUrl + "collections/" + collectionId + "/followers";
    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print(response.body);
      is_following = true;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Unfollow collection
  Future<void> unfollowCollection(String collectionId) async {
    final token = await storage.read(key: "token");
    String url = baseUrl + "collections/" + collectionId + "/followers";
    try {
      final response = await http.delete(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print(response.body);
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
