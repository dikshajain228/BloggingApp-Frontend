import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './article_preview_card.dart';
import '../providers/articles.dart';
import 'package:provider/provider.dart';

class ArticlesList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final articlesData = Provider.of<Articles>(context);
    final articles = articlesData.articles;
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (_, index)  => ChangeNotifierProvider(

          builder: (c) => articles[index],
          child : ArticlePreviewCard(
          //List Tile cards

//            articles[index].article_id,
//            articles[index].image_path,
//            articles[index].title,
//            articles[index].date_updated,
//            articles[index].bookmarked
        ),
        ),

        );
  }
}