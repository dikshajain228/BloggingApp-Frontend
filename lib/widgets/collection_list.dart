import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../widgets/collection_preview_card.dart';

class CollectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collectionsData = Provider.of<Collections>(context);
    final collections = collectionsData.collections;

    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: collections[index],
        child: CollectionPreviewCard(),
      ),
    );
  }
}
