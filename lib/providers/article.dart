import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../server_util.dart' as Server;

class Article with ChangeNotifier {
  final String article_id;
  final String collection_id;
  final int user_id;
  String title;
  String content;
  bool published;
  String image_path;
  int views_count;
  int kudos_count;
  final DateTime date_created;
  DateTime date_updated;
  bool is_bookmarked;
  String tags;
  bool is_author;

  static const baseUrl = Server.SERVER_IP + "/api/v1/";
  final storage = FlutterSecureStorage();

  Article({
    @required this.article_id,
    @required this.collection_id,
    @required this.user_id,
    @required this.title,
    this.content,
    this.published,
    this.image_path,
    this.views_count,
    this.kudos_count,
    this.date_created,
    this.date_updated,
    this.is_bookmarked,
    this.tags,
    this.is_author,
  });

  //Delete article
  Future<void> deleteArticle(String articleId) async{
    final token  = await storage.read(key : "token");
    String url = baseUrl+"articles/"+articleId;
    print(url);
    try{
      final response = await http.delete(
        url,
        headers : {HttpHeaders.authorizationHeader : token},
      );
      print("Delete please babeyy");
      print(response);
      notifyListeners();
    }catch(error){
      throw error;
    }

  }

  // Add bookmark
  Future<void> addBookmark(String articleId) async {
    String url = baseUrl + "user/bookmarks/" + articleId;
    final token = await storage.read(key: "token");
    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      // final responseJson = json.decode(response.body);
      print(response.body);
      is_bookmarked = true;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Remove bookmark
  Future<void> removeBookmark(String articleId) async {
    String url = baseUrl + "user/bookmarks/" + articleId;
    final token = await storage.read(key: "token");
    try {
      final response = await http.delete(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      // final responseJson = json.decode(response.body);
      print(response.body);
      is_bookmarked = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void setUnsetbookmark() {
    is_bookmarked = !is_bookmarked;
    notifyListeners();
  }
}
