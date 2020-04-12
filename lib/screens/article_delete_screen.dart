import 'package:flutter/material.dart';

import '../widgets/article_delete_list.dart';

class ArticleDeleteScreen extends StatefulWidget {
  static const routeName = "/delete-article-page";

  @override
  _ArticleDeleteScreenState createState() => _ArticleDeleteScreenState();
}

class _ArticleDeleteScreenState extends State<ArticleDeleteScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff191654),
                  Color(0xff43c6ac),
                  // Color(0xff6dffe1),
                ]),
          ),
        ),
        title: Text('Delete Articles'),
      ),
      body: ArticlesDeleteList(),
    );
  }
}
