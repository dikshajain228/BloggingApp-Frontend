import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Collection with ChangeNotifier {
  final String collection_id;
  final int user_id;
  String collection_name;
  String image_url;
  String description;
  bool user_only; //Will be removed
  String is_owner;
  String is_author;
  String is_following;
  dynamic authors;

  Collection(
      {@required this.collection_id,
      @required this.user_id,
      @required this.collection_name,
      this.image_url,
      this.description,
      this.user_only,
      this.is_owner,
      this.is_author,
      this.is_following,
      this.authors});

  void follow() {
    this.is_following = "True";
    notifyListeners();
  }

  void unFollow() {
    this.is_following = "False";
    notifyListeners();
  }
}
