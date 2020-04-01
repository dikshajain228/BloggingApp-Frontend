import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './article_delete_card.dart';
import '../providers/articles.dart';

class ArticlesDeleteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articlesData = Provider.of<Articles>(context);
    final articles = articlesData.articles;
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: articles[index],
//        builder: (c) => articles[index],
        child:ArticleDeleteCard(),
      ),
    );
  }
}
