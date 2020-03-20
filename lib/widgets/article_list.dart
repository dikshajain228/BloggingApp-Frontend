import 'package:flutter/material.dart';
import 'package:bloggingapp/screens/HomePage.dart';

Widget makeListTile(BuildContext context, String image, String title,
    DateTime date) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      child: new Image.network(image),
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(date.toString(), style: TextStyle(color: Colors.black)),
    trailing: Icon(Icons.bookmark_border, color: Colors.black, size: 30.0),
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ArticlePage()));
    },
  );
}