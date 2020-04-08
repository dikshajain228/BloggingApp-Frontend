import '../widgets/article_delete_list.dart';
import 'package:flutter/material.dart';
import '../widgets/article_delete_list.dart';
import '../widgets/drawer.dart';

class ArticleDeleteScreen extends StatefulWidget {
  static const routeName = "/delete-article-page";

  @override
  _ArticleDeleteScreenState createState() => _ArticleDeleteScreenState();
}

class _ArticleDeleteScreenState extends State<ArticleDeleteScreen> {
  void initState() {
    print("HEllo I am in delete article init state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Article'),
      ),
      body: ArticlesDeleteList(),
    );
  }
}
