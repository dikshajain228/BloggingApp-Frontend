import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

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

  Article(
      {@required this.article_id,
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
      this.is_bookmarked});

  void setUnsetbookmark() {
    is_bookmarked = !is_bookmarked;
    notifyListeners();
  }
}
