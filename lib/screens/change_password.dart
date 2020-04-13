import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../screens/profile_screen.dart';

import '../providers/users.dart';

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


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Change Password"),
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
        ),
         body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              autovalidate: true,
              
              child: Column(children: <Widget>[
                 SizedBox(height: 20),
                //new Text('Enter current password',style: new TextStyle( fontSize: 18.0),textAlign:TextAlign.start),
                TextFormField(
                  controller: _oldPasswordController,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter current password',),
                      validator: (value) {
                    if (value.length == 0) {
                      return 'This feild cannot be empty ';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                //new Text('Enter new password',style: new TextStyle( fontSize: 18.0),textAlign: TextAlign.left),
                TextFormField(
                  controller: _newPassword1Controller,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter new password',),
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
                //new Text('Enter current password',style: new TextStyle( fontSize: 18.0),textAlign: TextAlign.left),
                SizedBox(height: 20),
                TextFormField(
                  controller: _newPassword2Controller,
                  decoration:   new InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-enter new password',),
                  keyboardType: TextInputType.text,
                  validator: (value2) {
                    if (value2.length == 0) {
                      return 'This feild cannot be empty ';
                    }
                    if (_newPassword1Controller.text.toString() !=
                        _newPassword2Controller.text.toString()) {
                      return "New password and conform password dont match";
                    }
                    return null;
                  },
                ),

              SizedBox(height: 20),
                ButtonTheme(
                minWidth: 400.0,
                height: 40.0,
                child: RaisedButton(
                onPressed: () {_showSaveDialog();},
                child: new Text("Confirm", style: TextStyle(fontSize: 20.0)),
                        textColor: Colors.white,
                         color: Theme.of(context).colorScheme.primary,
                    ),
                ),

                 
              ]),
            )
            )
            );
  }

  void _updatePassword() async {
    if (_formKey.currentState.validate()) {
      String oldPassword = _oldPasswordController.text;
      String newPassword = _newPassword1Controller.text;
      Provider.of<Users>(context)
          .changePassword(oldPassword, newPassword)
          .then((message) {
        Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
        Toast.show("Password changed successfully.", context,
            duration: 7, gravity: Toast.BOTTOM);
      }).catchError((errorMessage) {
        print(errorMessage);
        Toast.show(errorMessage, context,
            duration: 7, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
      });
    }
  }

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
            content: Text("Change password?"),
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
                  _updatePassword();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
