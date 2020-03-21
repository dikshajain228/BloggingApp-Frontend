import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/articles.dart';

class ArticlePage extends StatelessWidget {
//  final String title;
//  ArticlePage(this.title);
  static const routeName = "/article-page";
  @override
  Widget build(BuildContext context) {
    final article_id = ModalRoute.of(context).settings.arguments as String;
    final article = Provider.of<Articles>(context, listen: false).findById(article_id);
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Text('Page still under construction'),
      ),
    );
  }
}
