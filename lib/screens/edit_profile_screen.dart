import 'dart:io';
import 'package:toast/toast.dart';
import '../widgets/image_input.dart';

import '../screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/users.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';
  User user;
  EditProfile(this.user);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = new GlobalKey<FormState>();

  final _username = TextEditingController();
  final _about = TextEditingController();
  File uploadedImage;

  void initState() {
    super.initState();
    print("Edit Profile Page");
    _username.text = widget.user.username;
    _about.text = widget.user.about;
  }

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }

  void saveChanges() {
    //Call function to edit changes
    Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
  }

  void cancelChanges() {
    Navigator.of(context).pushReplacementNamed((ProfilePage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: cancelChanges,
        // ),
        title: Text('Edit Profile...'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed:  _showSaveDialog,
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
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: FittedBox(
                    child: ImageInput(
                        uploadedImage, setImage, widget.user.profile_image_url),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                  child: TextFormField(
                    controller: _username,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value){
                      if(value.isEmpty) return "Username cant be empty";
                      return null;
                    }
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  controller: _about,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfile() {
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
    String username = _username.text;
    String about = _about.text;
    final data = {
      "username": username,
      "about": about,
      "imageUrl": widget.user.profile_image_url,
    };
   Provider.of<Users>(context).updateProfile(data, uploadedImage).then((_) {
        Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
        Toast.show("User profile edited successfully!", context, duration:7, gravity:  Toast.BOTTOM);
      })
       .catchError((onError){
       print("Unsuccessful.");
       Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
       Toast.show("Profile could not be edited.Please try again.", context, duration:7, gravity:  Toast.BOTTOM);
    });
  }

  void _showSaveDialog() {
    if(_formKey.currentState.validate()){
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
                  _updateProfile();
                  Navigator.of(context).pop();
                  //Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
