import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  void initState() {
    print("Hello I am in editProfile Page");
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  //textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  //textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                GestureDetector(
                  child: Text("Change profile picture"),
                  onTap: () async {
                    var file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    print("fhjb,n.lkm/lm nkjh jh hjjkolklj ilr");
                    print(file);
                    var ImageFormData =
                        http.MultipartFile.fromPath('image', file.path);
                    print(ImageFormData);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
