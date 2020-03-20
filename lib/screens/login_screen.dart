import 'package:flutter/material.dart';

class LoginRegisterState extends State<LoginRegisterPage> {
  final formKey = new GlobalKey<FormState>();

  String formType = "login";
  String email = "";
  String password = "";
  String username = "";

  bool saveForm() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      formType = "register";
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      formType = "login";
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text("Flutter Blog App"),
        ),
        body: SingleChildScrollView(
            child: new Container(
              margin: EdgeInsets.all(25.0),
              child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createInputs() + createButtons(),
                ),
              ),
            )));
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) {
            return value.isEmpty ? 'Email required' : null;
          },
          onSaved: (value) {
            return email = value;
          }),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
          decoration: new InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            return value.isEmpty ? 'Password required' : null;
          },
          onSaved: (value) {
            return password = value;
          }),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  List<Widget> createButtons() {
    if (formType == "login") {
      return [
        new RaisedButton(
          child: new Text("Login", style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.purple,
          onPressed: saveForm,
        ),
        new FlatButton(
          child: new Text("Dont have an account? Create Account?",
              style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.deepPurple,
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        new TextFormField(
            decoration: new InputDecoration(labelText: 'Username'),
            validator: (value) {
              return value.isEmpty ? 'Username required' : null;
            },
            onSaved: (value) {
              return username = value;
            }),
        new RaisedButton(
          child: new Text("Create account", style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.purple,
          onPressed: saveForm,
        ),
        new FlatButton(
          child: new Text("Have an account? Login",
              style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.deepPurple,
          onPressed: moveToLogin,
        )
      ];
    }
  }

  Widget logo() {
    return new CircleAvatar(
      radius: 110.0,
      backgroundColor: Colors.transparent,
      child: Image.asset('assests/images/logo.png'),
    );
  }
}

class LoginRegisterPage extends StatefulWidget {
  @override
  LoginRegisterState createState() => LoginRegisterState();
}
