import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/collection.dart';

class CollectionPreviewCard extends StatelessWidget {
  Widget build(BuildContext context) {
    final collection = Provider.of<Collection>(context);

    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(75.0)),
              ),
              child: Image.network(collection.image_url)),
          title: Text(
            collection.collection_name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: collection.is_following ? Colors.blue : Colors.black,
            ),
            onPressed: () {
              collection.followUnfollow();
            },
          ),
        ),
      ),
    );
  }
}
