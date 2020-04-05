import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart' as Constants;

import './collection.dart';

class Collections with ChangeNotifier {
  static const baseUrl = Constants.SERVER_IP+"api/v1/";
  final storage = FlutterSecureStorage();

  List<Collection> _collections = [];

  List<Collection> get collections {
    return [..._collections];
  }

  // Get User owned or authored collections
  Future<void> getUserCollections() async {
    List<Collection> fetchedCollections = [];
    final token = await storage.read(key: "token");
    print("Obtained token user collection");
    final userId = await storage.read(key: "userId");

    String url = baseUrl + "user/" + userId.toString() + "/collections";

    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      final responseJson = json.decode(response.body);
      for (final collection in responseJson) {
        fetchedCollections.add(Collection(
          collection_id: collection["collection_id"],
          user_id: collection["user_id"],
          collection_name: collection["collection_name"],
          image_url: collection["image_url"],
          description: collection["description"],
          is_owner: collection["is_owner"] == 0 ? false : true,
          is_author: collection["is_author"] == 0 ? false : true,
          is_following: false,
        ));
      }
      _collections = [...fetchedCollections];
    } catch (error) {
      throw error;
    }
  }

// Get collection by ID
// Change name to get
  Future<Collection> fetchCollectionById(String collectionId) async {
    final token = await storage.read(key: "token");
    String url = baseUrl + "collections/" + collectionId;
    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      final responseJson = json.decode(response.body);
      final data = responseJson[0];
      Collection collection = Collection(
        collection_id: data["collection_id"],
        collection_name: data["collection_name"],
        user_id: data["user_id"],
        image_url: data["image_url"],
        description: data["description"],
        is_owner: data["is_owner"] == 0 ? false : true,
        is_author: data["is_author"] == 0 ? false : true,
        is_following: data["is_following"] == 0 ? false : true,
        authors: data["authors"],
      );
      print("Authors");
      print(collection.authors);
      return collection;
    } catch (error) {
      throw error;
    }
  }

  // Add new collection
  Future<void> addCollection(Map<String, dynamic> data, File image) async {
    print(data);
    final token = await storage.read(key: "token");
    final userId = await storage.read(key: "userId");
    String collectionId =
        userId.toString() + (DateTime.now().millisecond).toString();
    String url = baseUrl + "collections";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers["Authorization"] = token;
    if (image != null) {
      String filename = image.path;
      request.files.add(await http.MultipartFile.fromPath('image', filename));
    }
    request.fields["collection_id"] = collectionId;
    request.fields["user_id"] = userId;
    request.fields["collection_name"] = data["collectionName"];
    request.fields["description"] = data["description"];
    request.fields["image_url"] = "";
    try {
      final response = await request.send();
      print(response);
    } catch (error) {
      throw error;
    }
  }

// Add new collection
  Future<void> updateCollection(Map<String, dynamic> data, File image) async {
    print(data);
    final token = await storage.read(key: "token");

    String collectionId = data["collectionId"];
    String url = baseUrl + "collections/" + collectionId;

    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers["Authorization"] = token;

    if (image != null) {
      String filename = image.path;
      request.files.add(await http.MultipartFile.fromPath('image', filename));
    }
    request.fields["description"] = data["description"];
    request.fields["image_url"] = data["imageUrl"];
    request.fields["tags"] = data["tags"];

    try {
      final response = await request.send();
      print(response);
    } catch (error) {
      throw error;
    }
  }

  // Search Collections
  Future<void> searchCollections(String query) async {
    List<Collection> fetchedCollections = [];
    final token = await storage.read(key: "token");

    String base = Constants.base;
    String path = "/api/v1/collections";
    var queryParams = {"q": query};
    var url = Uri.http(base, path, queryParams);
    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: token},
      );
      print(response.body);
      final responseJson = json.decode(response.body);
      for (final collection in responseJson) {
        fetchedCollections.add(Collection(
          collection_id: collection["collection_id"],
          user_id: collection["user_id"],
          collection_name: collection["collection_name"],
          image_url: collection["image_url"],
          description: collection["description"],
          is_owner: collection["is_owner"] == 0 ? false : true,
          is_author: collection["is_author"] == 0 ? false : true,
          is_following: collection["is_following"] == 0 ? false : true,
        ));
      }
      _collections = [...fetchedCollections];
    } catch (error) {
      throw error;
    }
  }

  Collection findById(String collection_id) {
    return _collections
        .firstWhere((collection) => collection.collection_id == collection_id);
  }

  void getCollections() {
    // Get data from server
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url:
          "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      description: "Stories through the eyes of a teenager",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));
    fetchedData.add(Collection(
      collection_id: "2",
      collection_name: "Personal Growth",
      user_id: 2,
      image_url:
          "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      description: "Sharing our ideas and experiences.",
      is_owner: true,
      is_author: false,
      is_following: false,
    ));
    fetchedData.add(Collection(
      collection_id: "3",
      collection_name: "Personal lala Growth",
      user_id: 3,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: false,
      is_author: true,
      is_following: false,
    ));

    _collections = fetchedData;
    // notifyListeners();
  }

  Collection getCollectionById(String collection_id) {
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url:
          "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      description: "Stories through the eyes of a teenager",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));
    fetchedData.add(Collection(
      collection_id: "2",
      collection_name: "Personal Growth",
      user_id: 2,
      image_url:
          "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      description: "Sharing our ideas and experiences.",
      is_owner: true,
      is_author: false,
      is_following: false,
    ));
    fetchedData.add(Collection(
      collection_id: "3",
      collection_name: "Personal lala Growth",
      user_id: 3,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: false,
      is_author: true,
      is_following: false,
    ));
    // Make call to get a single collection
    return fetchedData
        .firstWhere((collection) => collection.collection_id == collection_id);
  }

  Future<void> getUsersCollections() async {
    // Pass token from local storage
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "Personal lala Growth",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: true,
      is_author: false,
      is_following: false,
    ));

    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "me me me",
      user_id: 5,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "all about me.",
      is_owner: true,
      is_author: false,
      is_following: false,
    ));

    _collections = fetchedData;
    notifyListeners();
  }

  Future<void> getFollowingCollection() async {
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "6",
      collection_name: "haha 123 haha",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "lalalalalala.",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));

    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "Everything",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "This that here there.",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));

    _collections = fetchedData;
    notifyListeners();
  }
}
