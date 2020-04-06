import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart' as Constants;

class Author {
  final int user_id;
  final String username;
  final String email;
  final String image_url;

  static const baseUrl = Constants.SERVER_IP + "/api/v1/";
  static const storage = FlutterSecureStorage();

  Author(this.user_id, this.username, this.email, this.image_url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Author &&
          runtimeType == other.runtimeType &&
          user_id == other.user_id;

  @override
  int get hashCode => username.hashCode;

  @override
  String toString() {
    return username.toString();
  }

  static Future<List<Author>> getSuggestions(String query) async {
    List<Author> fetchedAuthors = [];

    final token = await storage.read(key: "token");

    String base = Constants.base;
    String path = "/api/v1/users";
    var queryParams = {"prompt": query};
    var url = Uri.http(base, path, queryParams);

    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      final responseJson = json.decode(response.body);
      // print(responseJson);
      for (final author in responseJson) {
        fetchedAuthors.add(Author(
          author["user_id"],
          author["username"],
          author["email"],
          author["profile_image_url"],
        ));
      }
      print("api call");
      print(fetchedAuthors);
      return fetchedAuthors;
    } catch (error) {
      throw error;
    }
  }
}
