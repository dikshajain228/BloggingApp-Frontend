import 'package:flutter/material.dart';
import 'package:bloggingapp/widgets/article_list.dart';


Widget article_preview_card(BuildContext context, String image, String title,
    DateTime date) {
  //Post card
  return new Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(),
      child: makeListTile(context, image, title, date),
    ),
  );
}