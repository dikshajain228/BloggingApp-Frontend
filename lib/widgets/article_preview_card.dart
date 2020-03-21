import 'package:flutter/material.dart';
import 'package:bloggingapp/screens/article_page.dart';
class ArticlePreviewCard extends StatelessWidget {
  final String image;
  final String article_id;
  String title;
  DateTime date;
  bool bookmarked;
  ArticlePreviewCard(this.article_id,this.image, this.title, this.date, this.bookmarked);

  Widget build(BuildContext context) {
    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: ListTile(
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
          trailing: bookmarked
              ? IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            onPressed: () {
              bookmarked = false;
            },
          )
              : IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black, size: 30.0),
            onPressed: () {
              bookmarked = true;
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ArticlePage.routeName, arguments: article_id );
          },
        ),
      ),
    );
  }
}

