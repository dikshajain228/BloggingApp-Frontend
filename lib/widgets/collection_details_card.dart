import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collection.dart';

class CollectionDetailsCard extends StatelessWidget {
  Collection collection;
  CollectionDetailsCard({this.collection});

  @override
  Widget build(BuildContext context) {
    print(collection.collection_id);
    print(collection.collection_name);
    String url =
        "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
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
                    child: Image.network(url),
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
                    "My stuff",
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
        Container(
          color: Colors.blueGrey[100],
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Followers",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "1000",
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
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Articles",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "1000",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
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
