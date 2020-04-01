import 'dart:io';
import 'package:bloggingapp/widgets/image_input.dart';

import '../screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/users.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';
   var profile_id;
  EditProfile(this.profile_id);
 
  @override
  _EditProfileState createState() => _EditProfileState(profile_id);
   
  
}

class _EditProfileState extends State<EditProfile> {

  var profile_id;
  User user;
 _EditProfileState(this.profile_id);

  void initState() {
    super.initState();
    print("Edit Profile Page");
    print(this.profile_id);
    
  }
  File uploadedImage;
  String image_url = "https://picsum.photos/200";

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }

  void saveChanges(){
    //Call function to edit changes
    Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
  }

  void cancelChanges(){
    Navigator.of(context).pushReplacementNamed((ProfilePage.routeName));
  }

  @override
  Widget build(BuildContext context) {
      //User user = ModalRoute.of(context).settings.arguments;
     //print(context);

    User user = Provider.of<Users>(context).getUserProfile();
    print(user.about);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: cancelChanges,
        ),
        title: Text('Edit Profile'),
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
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: ClipOval(
                    child: Image.network(
                      "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk",
                      fit: BoxFit.cover,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                ),
                FlatButton(
              child: Text("Change profile picture."),
              color: Colors.white,
              splashColor: Colors.tealAccent,
              onPressed: () {

                print("thj");
                       showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
              child: Text("Change"),
              color: Colors.teal,
              splashColor: Colors.tealAccent,
              onPressed: () {
               
              },
            ),
          ],
        );
      },
    );
     
              },
            ),
               
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 16.0),
                  child: TextFormField(
                    initialValue: user.username,
                    decoration: InputDecoration(labelText: 'Username'),
                    //textInputAction: TextInputAction.next,
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  initialValue: user.about,
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
