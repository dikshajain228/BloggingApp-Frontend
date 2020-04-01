import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/article_test_screen.dart';

import '../providers/article.dart';

class ArticlePreviewCard extends StatelessWidget {
//  final String image;
//  final String article_id;
//  String title;
//  DateTime date;
//  bool is_bookmarked;
//  ArticlePreviewCard(
//      this.article_id, this.image, this.title, this.date, this.is_bookmarked);

  Widget build(BuildContext context) {
    final article = Provider.of<Article>(context);

    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: ClipOval(
            child: Image.network(
              article.image_path,
              fit: BoxFit.cover,
              height: 50.0,
              width: 50.0,
            ),
          ),
          title: Text(
            article.title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
              "Published on " +
                  DateFormat("dd-MM-yyyy").format(article.date_created),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              )),
          trailing: IconButton(
            icon: Icon(
              article.is_bookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              article.setUnsetbookmark();
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleScreenTest.routeName,
                arguments: article.article_id);
          },
        ),
      ),
    );
  }
}
