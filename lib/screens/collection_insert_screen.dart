import 'dart:io';
import 'package:bloggingapp/providers/collection.dart';
import 'package:bloggingapp/providers/collections.dart';
import 'package:flutter/material.dart';

// widgets
import '../widgets/authors_input.dart';
import '../widgets/image_input.dart';

class CollectionInsertScreen extends StatefulWidget {
  static const routeName = "/collection/insert";
  @override
  CollectionInsertScreenState createState() => CollectionInsertScreenState();
}

class CollectionInsertScreenState extends State<CollectionInsertScreen> {
  List<dynamic> authors = [];

  final _collectionName = TextEditingController();
  final _collectionDescription = TextEditingController();

  File uploadedImage;
  String image_url = "https://picsum.photos/200";

  @override
  void initState() {
    super.initState();
    // Initial content of text editor
  }

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }

  void setAuthors(List<dynamic> authorsData) {
    setState(() {
      authors = [...authorsData];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Collection collection = Provider.of<Collections>(context).addCollection();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Collection'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: saveChanges,
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
                      )
                    ),
                   ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Collection Name'),
                    controller: _collectionName,
                    //textInputAction: TextInputAction.next,
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

  void saveChanges() {
    _showSaveDialog();
    print("Collection Name: "+_collectionName.text);
    print("Collection Description: "+_collectionDescription.text);
  }

  void _submitCollection() {
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
  }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Post New Collection",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                AuthorsInput(authors, setAuthors),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
              color: Colors.red,
              splashColor: Colors.redAccent,
            ),
            FlatButton(
              child: Text("Post"),
              color: Colors.teal,
              splashColor: Colors.tealAccent,
              onPressed: () {
                _submitCollection();
                print("Authors");
                print(authors);
              },
            ),
          ],
        );
      },
    );
  }
}
