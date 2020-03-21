import 'package:flutter/widgets.dart';

class Article {
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
  bool bookmarked;

  Article(
      {@required this.article_id,
      @required this.collection_id,
      @required this.user_id,
      @required this.title,
      @required this.content,
      @required this.published,
      @required this.image_path,
      @required this.views_count,
      @required this.kudos_count,
      @required this.date_created,
      @required this.date_updated,
      this.bookmarked});
}
