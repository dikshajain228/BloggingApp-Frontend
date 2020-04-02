import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../widgets/collection_preview_card.dart';

class CollectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collections = Provider.of<Collections>(context).collections;

    return (collections.length == 0
        ? Center(
            child: Container(
              child: Text("No collections"),
            ),
          )
        : ListView.builder(
            itemCount: collections.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: collections[index],
              child: CollectionPreviewCard(),
            ),
          ));
  }
}
