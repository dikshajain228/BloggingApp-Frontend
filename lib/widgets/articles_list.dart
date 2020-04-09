import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './article_preview_card.dart';
import '../providers/articles.dart';

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<Articles>(context).articles;

    return (articles.length == 0
        ? Center(
            child: Container(
              child: Text("Follow collections to view articles"),
            ),
          )
        : ListView.builder(
            itemCount: articles.length,
            itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: articles[index],
//        builder: (c) => articles[index],
              child: ArticlePreviewCard(),
            ),
          ));
  }
}
