import '../screens/collection_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/collection.dart';
import '../providers/collections.dart';


class EditCollection extends StatefulWidget {
  static const routeName = '/edit-collection';
  @override
  _EditCollectionState createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  void initState() {
    print("Hello I am in editCollection Page");
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Publish changes",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                 //Call function to edit changes
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            
          ],
        );
      },
    );
  }

  void saveChanges(){
   
    _showSaveDialog();
   
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
                            child: Image.network(collection.image_url),
                      ),
                   ),
                ],
            ),
                GestureDetector(
                  child: Text("\nChange collection image", style: TextStyle(color: Colors.blue),),
                  onTap: () async {
                    var file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);

                    print(file);
                    var ImageFormData =
                    http.MultipartFile.fromPath('image', file.path);
                    print(ImageFormData);
                  },
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
}
