import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// widgets
import '../widgets/authors_input.dart';
import '../widgets/image_input.dart';

import '../providers/collections.dart';
import '../providers/collection.dart';

class CollectionInsertScreen extends StatefulWidget {
  static const routeName = "/collection/insert";
  @override
  CollectionInsertScreenState createState() => CollectionInsertScreenState();
}

class CollectionInsertScreenState extends State<CollectionInsertScreen> {
  final _collectionName = TextEditingController();
  final _collectionDescription = TextEditingController();

  File uploadedImage;
  String image_url = "https://picsum.photos/200";

  @override
  void initState() {
    super.initState();
  }

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Collection'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _insertCollection,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: (FittedBox(
                    fit: BoxFit.fill,
                    child: Column(
                      children: <Widget>[
                        ImageInput(uploadedImage, setImage, image_url),
                      ],
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Collection Name'),
                    controller: _collectionName,
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  decoration:
                      InputDecoration(labelText: 'Collection Description'),
                  controller: _collectionDescription,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _insertCollection() {
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
    String collectionName = _collectionName.text;
    String description = _collectionDescription.text;
    final data = {"collectionName": collectionName, "description": description};
    print("form submit");
    print(collectionName);
    print(description);
    Provider.of<Collections>(context)
        .addCollection(data, uploadedImage)
        .then((_) {
      print("Inserted");
    });
  }
}
