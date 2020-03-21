import 'package:flutter/material.dart';
import 'package:bloggingapp/widgets/header.dart';
class ArticlePage extends StatelessWidget {
//  final String title;
//  ArticlePage(this.title);
  static const routeName = "/article-page";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Text('Page still under construction'),
      ),
    );
  }
}
