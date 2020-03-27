import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collection.dart';

class CollectionDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final collection = Provider.of<Collection>(context);
    return (Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(collection.image_url),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white38,
              width: double.maxFinite,
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    collection.collection_name,
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
                  child: Text(collection.description,
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
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
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "10" + " followers",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: collection.is_following
                      ? FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            collection.followUnfollow();
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
                            collection.followUnfollow();
                          },
                          child: Text("Follow"),
                        ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
