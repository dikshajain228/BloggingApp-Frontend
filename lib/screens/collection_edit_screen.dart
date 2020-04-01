import 'dart:io';
import '../screens/collection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/collection.dart';
import '../providers/collections.dart';
import '../widgets/image_input.dart';


class EditCollection extends StatefulWidget {
  static const routeName = '/collection/edit';
  var collection_id;
  EditCollection(this.collection_id);

  @override
  _EditCollectionState createState() => _EditCollectionState(collection_id);
  //_EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection>  {

     
  var collection_id;
  Collection collection;

  _EditCollectionState(this.collection_id);

   void initState() {
    super.initState();
    print("Edit Collection Page.");
    print(collection_id);
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
    final _collectionName = TextEditingController(text:collection.collection_name);
     final _collectionDescription = TextEditingController(text:collection.description);

     

    print(collection.description);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Collection'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed:saveChanges,
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
                   //initialValue:collection.collection_name,
                   decoration: InputDecoration(labelText: 'Collection Name'),
                   controller:_collectionName,
                    
                  )
                  
                ), 
                
                TextFormField( 
                  maxLines: 3,
                  //initialValue:collection.description,
                   decoration: InputDecoration(labelText: 'Description'),
                  controller: _collectionDescription,
                  
                ),


              ],
              
            ),
           
         ),
        ),
        
      ),
      
    );

    void _printChanges(){
      print("Collection Name: "+_collectionName.text);
       print("Collection Description: "+_collectionDescription.text);

    }
}

void  saveChanges() {
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
            "Edit the Collection?",
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
                _submitCollection();
              },
            ),
          ],
        );
      },
    );
  }
}
