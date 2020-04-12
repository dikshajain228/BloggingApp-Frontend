import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../screens/collection_screen.dart';

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

  final _formKey = new GlobalKey<FormState>();

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

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Collection...'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff191654),
                  Color(0xff43c6ac),
                  // Color(0xff6dffe1),
                ]),
          ),
        ),
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
          key: _formKey,
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
                      readOnly: true,
                      validator: (value) {
                        if (value.isEmpty) return 'Collection Name required';
                        return null;
                      }),
                ),
                TextFormField(
                  maxLines: 3,
                  decoration:
                      InputDecoration(labelText: 'Collection Description'),
                  controller: _collectionDescription,
                  cursorColor: Theme.of(context).cursorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateCollection() {
    // String collectionName = _collectionName.text;
    String description = _collectionDescription.text;
    final data = {
      "collectionId": widget.collection.collection_id,
      "description": description,
      "imageUrl": widget.collection.image_url,
      "tags": "",
    };
    Provider.of<Collections>(context)
        .updateCollection(data, uploadedImage)
        .then((message) {
      print(message);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(CollectionScreen.routeName,
          arguments: widget.collection.collection_id);
      Toast.show("Updated Successfully!", context,
          duration: 7, gravity: Toast.BOTTOM);
    }).catchError((errorMessage) {
      print(errorMessage);
      Navigator.of(context).pop();
      // pop dialog box and stay on page
      // Navigator.of(context).pushReplacementNamed(EditCollection.routeName);
      displayDialog(
        context,
        "Error",
        errorMessage,
      );
    });
  }

  // Save alert dialog
  void _showSaveDialog() {
    if (_formKey.currentState.validate()) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                'Save Changes',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            content: Text("Save changes made to the collection?"),
            actions: [
              FlatButton(
                textColor: Theme.of(context).colorScheme.error,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              FlatButton(
                child: Text("Save"),
                textColor: Theme.of(context).colorScheme.secondary,
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
}
