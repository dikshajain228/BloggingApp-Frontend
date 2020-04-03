import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

import '../providers/collection.dart';
import '../providers/collections.dart';

class EditCollection extends StatefulWidget {
  static const routeName = '/collection/edit';
  Collection collection;
  EditCollection(this.collection);

  @override
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  final _collectionName = TextEditingController();
  final _collectionDescription = TextEditingController();
  File uploadedImage;

  void initState() {
    super.initState();
    print("Edit Collection Page.");
    print(widget.collection.collection_id);
    _collectionName.text = widget.collection.collection_name;
    _collectionDescription.text = widget.collection.description;
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
        title: Text('Edit Collection...'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _showSaveDialog,
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
                        ImageInput(uploadedImage, setImage,
                            widget.collection.image_url),
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

  void _updateCollection() {
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
    String collectionName = _collectionName.text;
    String description = _collectionDescription.text;
    final data = {
      "collectionId": widget.collection.collection_id,
      "description": description,
      "imageUrl": widget.collection.image_url,
      "tags": "",
    };
    print("form submit");
    print(collectionName);
    print(description);
    Provider.of<Collections>(context)
        .updateCollection(data, uploadedImage)
        .then((_) {
      print("Updated");
    });
  }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm changes ?",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("No"),
              color: Colors.red,
              splashColor: Colors.redAccent,
            ),
            FlatButton(
              child: Text("Yes"),
              color: Colors.teal,
              splashColor: Colors.tealAccent,
              onPressed: () {
                _updateCollection();
              },
            ),
          ],
        );
      },
    );
  }
}
