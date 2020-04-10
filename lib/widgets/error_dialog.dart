import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  String errorMessage;
  ErrorDialog({@required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Text(
          'Error...',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      content: Text(errorMessage),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          textColor: Colors.black,
          splashColor: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
