import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/article_preview_card.dart';
import '../providers/collections.dart';

class CollectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collectionData = Provider.of<Collections>(context);
    final articles = collectionData.collections;
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: articles[index],
//        builder: (c) => articles[index],
        child: ArticlePreviewCard(//Replace with collection card
            //List Tile cards

//            articles[index].article_id,
//            articles[index].image_path,
//            articles[index].title,
//             articles[index].date_updated,
//            articles[index].bookmarked
            ),
      ),
    );
  }
}
