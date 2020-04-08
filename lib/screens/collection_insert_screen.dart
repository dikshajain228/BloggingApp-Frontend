import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

// widgets
import '../widgets/image_input.dart';

import '../providers/collections.dart';
import '../providers/collection.dart';
import '../screens/profile_page.dart';

class CollectionInsertScreen extends StatefulWidget {
  static const routeName = "/collection/insert";
  @override
  CollectionInsertScreenState createState() => CollectionInsertScreenState();
}

class CollectionInsertScreenState extends State<CollectionInsertScreen> {
  final _formKey = new GlobalKey<FormState>();

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
          key : _formKey,
          autovalidate: true,
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
                    validator: (value){
                      if(value.isEmpty) return 'Collection Name required';
                      return null;
                    }
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
    if(_formKey.currentState.validate()){
      if (uploadedImage != null) {
        print(uploadedImage.path);
      } else {
        print("no upload");
      }
      String collectionName = _collectionName.text;
      String description = _collectionDescription.text;
      final data = {"collectionName": collectionName, "description": description};
      print("form submit");
      Provider.of<Collections>(context)
          .addCollection(data, uploadedImage)
          .then((_) {
        print("Inserted");
        Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
        Toast.show("New collection added!", context, duration:7, gravity:  Toast.BOTTOM);
      })
      .catchError((onError){
       print("Unsuccessful.");
       Toast.show("A new collection could not be created.Please try again.", context, duration:7, gravity:  Toast.BOTTOM);
    });
    }
  }
}
