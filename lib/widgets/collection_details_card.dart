import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/collection.dart';

class CollectionDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _collection = Provider.of<Collection>(context);
    return (Column(
      children: [
        Stack(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: _collection.image_url,
                placeholder: (context, url) => Image.network(
                  "http://via.placeholder.com/640x360",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Image.network(
                  "http://via.placeholder.com/640x360",
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                ),
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            Container(
              color: Colors.white38,
              width: double.maxFinite,
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _collection.collection_name,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueGrey[100],
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
            ),
          ],
        ),
        Container(
          color: Colors.blueGrey[100],
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // No data
                // Expanded(
                //   flex: 6,
                //   child: Column(
                //     children: <Widget>[
                //       Text(
                //         "10" + " followers",
                //         style: TextStyle(
                //           fontSize: 17.0,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.blue,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                _collection.is_following
                    ? FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        onPressed: () {
                          _collection.followUnfollow();
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
                          _collection.followUnfollow();
                        },
                        child: Text("Follow"),
                      ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
