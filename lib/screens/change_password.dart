import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../screens/profile_page.dart';

import '../providers/user.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = "/profile/change-password";
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPassword1Controller = TextEditingController();
  final TextEditingController _newPassword2Controller = TextEditingController();


  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
      
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("I am Change Password page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Change Password"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(children: <Widget>[
                TextFormField(
                  controller : _oldPasswordController,
                  decoration: new InputDecoration(
                      labelText: '   Enter current Password'),
                  validator: (value) {
                    if (value.length == 0) {
                      return 'This feild cannot be empty ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller : _newPassword1Controller,
                  decoration:
                      new InputDecoration(labelText: '   Enter new Password'),
                  validator: (value1) {
                    if (value1.length == 0) {
                      return 'This feild cannot be empty';
                    }
                    if (value1.length < 6) {
                      return 'Weak Password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller : _newPassword2Controller,
                  decoration: new InputDecoration(
                      labelText: '   Re-enter new Password'),
                  //hintText: "Enter current Password",
                  keyboardType: TextInputType.text,
                  validator: (value2) {
                    if (value2.length == 0) {
                      return 'This feild cannot be empty ';
                    }
                    if (_newPassword1Controller.text.toString() != _newPassword2Controller.text.toString()) {
                      return "New password and conform password dont match";
                    }
                    return null;
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    int status;
                    if (_formKey.currentState.validate()) {
                      String oldPassword = _oldPasswordController.text;
                      String newPassword = _newPassword1Controller.text;
                          status = await Provider.of<User>(context).changePassword(oldPassword,newPassword);
                          
                          print(status);
                      if (status == 401)
                          Toast.show("Invalid password.Check your current password.", context, duration:7, gravity:  Toast.BOTTOM);
                        
                      else if (status == 200){
                        print("Password changed successfully");
                        Navigator.of(context).pushReplacementNamed(ProfilePage.routeName);
                        Toast.show("Password changed successfully.", context, duration:7, gravity:  Toast.BOTTOM);
                      }
                      else
                        displayDialog(
                          context,"Error",
                          "Unknown error occurred",
                        );
                       // Toast.show("Unknown error occurred.Please try agin.", context, duration:7, gravity:  Toast.BOTTOM);
                    }
                   
                  },
                  child: Text("Confirm Change"),
                  color: Colors.white,
                  splashColor: Colors.blueAccent,
                ),
              ]),
            )));
  }
}
