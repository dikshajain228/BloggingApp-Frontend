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
          leading: ClipOval(
            child: Image.network(
              collection.image_url,
              fit: BoxFit.cover,
              height: 50.0,
              width: 50.0,
            ),
          ),
          title: Text(
            collection.collection_name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          subtitle: Text(
            collection.description,
            overflow: TextOverflow.ellipsis,
          ),
          // Is owner
          trailing: collection.is_owner
              ? FlatButton(
                  color: Colors.purple,
                  disabledColor: Colors.deepOrange,
                  disabledTextColor: Colors.white,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  onPressed: null,
                  child: Text("Owner"),
                )
              // Is author
              : collection.is_author
                  ? FlatButton(
                      color: Colors.purple,
                      disabledColor: Colors.purple,
                      disabledTextColor: Colors.white,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      onPressed: null,
                      child: Text("Author"),
                    )
                  : collection.is_following
                      ?
                      // is following
                      FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            collection.followUnfollow();
                          },
                          child: Text("Following"),
                        )
                      // Follower
                      : OutlineButton(
                          color: Colors.blue,
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          textColor: Colors.blue,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            collection.followUnfollow();
                          },
                          child: Text("Follow"),
                        ),
          // IconButton(
          //     icon: Icon(
          //       Icons.add_circle,
          //       color: collection.is_following
          //           ? Theme.of(context).primaryColor
          //           : Colors.black,
          //     ),
          //     onPressed: () {
          //       collection.followUnfollow();
          //     },
          //   ),
        ),
      ),
    );
  }
}
