import '../screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/users.dart';

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

  void saveChanges(){
    //Call function to edit changes
    Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
  }

  void cancelChanges(){
    Navigator.of(context).pushReplacementNamed((ProfilePage.routeName));
  }

  @override
  Widget build(BuildContext context) {
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
                GestureDetector(
                  child: Text("Change profile picture", style: TextStyle(color: Colors.blue),),
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
