import 'package:flutter/material.dart';

class Opinion with ChangeNotifier {
  final String opinion_id;
  final String article_id;
  final String username;
  final String content;
  final DateTime opinion_date;
  final String user_profile_image_path;

  Opinion({
    @required this.opinion_id,
    @required this.article_id,
    @required this.username,
    @required this.content,
    @required this.opinion_date,
    @required this.user_profile_image_path,
  });
}
