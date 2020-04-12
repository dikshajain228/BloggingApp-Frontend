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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: _showSaveDialog,
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(children: <Widget>[
                TextFormField(
                  controller: _oldPasswordController,
                  decoration:
                      InputDecoration(labelText: '   Enter current Password'),
                  validator: (value) {
                    if (value.length == 0) {
                      return 'This feild cannot be empty ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _newPassword1Controller,
                  decoration: InputDecoration(labelText: '   Enter  Password'),
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
                  controller: _newPassword2Controller,
                  decoration:
                      InputDecoration(labelText: '   Re-enter  Password'),
                  //hintText: "Enter current Password",
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
              ]),
            )));
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
        displayDialog(
          context,
          "Error",
          errorMessage,
        );
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
