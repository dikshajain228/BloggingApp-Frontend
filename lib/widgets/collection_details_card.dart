import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/collection.dart';

class CollectionDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _collection = Provider.of<Collection>(context);
    return Container(
      color: Colors.teal[50],
      child: (Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Center(
              child: Text(
                _collection.collection_name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Container(
              height: 200,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: _collection.image_url,
                placeholder: (context, url) => Image.network(
                  "http://via.placeholder.com/640x360",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Image.network(
                  "http://via.placeholder.com/640x360",
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.blueGrey[100],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _collection.description,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            // color: Colors.blueGrey[100],
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _collection.is_following
                      ? FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            _collection
                                .unfollowCollection(_collection.collection_id)
                                .then((_) {
                              print("Unfollowed collection");
                            });
                          },
                          child: Text("Following"),
                        )
                      : OutlineButton(
                          color: Colors.blue,
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          textColor: Colors.blue,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            _collection
                                .followCollection(_collection.collection_id)
                                .then((_) {
                              print("Followed collection");
                            });
                          },
                          child: Text("Follow"),
                        ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
