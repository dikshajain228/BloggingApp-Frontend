import 'dart:io';
import '../screens/collection_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/collection.dart';
import '../providers/collections.dart';
import '../widgets/image_input.dart';


class EditCollection extends StatefulWidget {
  static const routeName = '/edit-collection';
  @override
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  void initState() {
    print("Hello I am in editCollection Page");
  }

  File uploadedImage;
  String image_url = "https://picsum.photos/200";

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    Collection collection = Provider.of<Collections>(context).getCollectionById("1");
    print(collection.description);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Collection'),
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
                 Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        //child: Image.network(collection.image_url),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                  child: TextFormField(
                    initialValue: collection.collection_name,
                    decoration: InputDecoration(labelText: 'Collection Name'),
                    //textInputAction: TextInputAction.next,
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  initialValue: collection.description,
                  decoration: InputDecoration(labelText: 'Description'),
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
            "Edit Collection",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                ImageInput(uploadedImage, setImage, image_url),
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
              },
            ),
          ],
        );
      },
    );
  }
}
