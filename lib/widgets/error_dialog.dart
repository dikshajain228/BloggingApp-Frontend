import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  String errorMessage;
  ErrorDialog({@required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error..."),
      content: Text(errorMessage),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
