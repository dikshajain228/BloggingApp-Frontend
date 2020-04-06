import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import '../providers/userAuthentication.dart';

import '../screens/home_screen.dart';

class LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();
  String formType = "login";

  final storage = FlutterSecureStorage();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  void _writeToken(String token) async {
    await storage.write(key: "token", value: token);
    final tokenPayload = token.split(".");
    final payloadMap = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(tokenPayload[1]))));
    print(payloadMap);
    await storage.write(key: "userId", value: payloadMap["user_id"].toString());
    await storage.write(key: "email", value: payloadMap["email"]);
  }

  // bool saveForm() {
  //   final form = formKey.currentState;
  //   if (form.validate()) {
  //     form.save();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  void moveToRegister() {
    //formKey.currentState.reset();

    setState(() {
      formType = "register";
    });
  }

  void moveToLogin() {
    //formKey.currentState.reset();

    setState(() {
      formType = "login";
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Blog App"),
      ),
      body: SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(25.0),
          child: new Form(
            key: formKey,
            autovalidate: true,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createButtons(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      logo(),
      new TextFormField(
        controller: _emailController,
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) {
          if(value.isEmpty)  return 'Email required';
          else{
            Pattern pattern = r"[A-Za-z0-9]*@[A-Za-z]+.[a-zA-Z]{2,}";
            RegExp regex = new RegExp(pattern);
            if(!regex.hasMatch(value))
              return 'Enter valid Email';
            else 
              return null;
          }
          return null;
        },
      ),
      new Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: TextFormField(
          controller: _passwordController,
          decoration: new InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            var err= null;
            if(value.isEmpty) err='Password required';
            else if(value.length<8) err='Password length should not be less than 8';
            return err;
          },
        ),
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
          onPressed: () async {
            final form = formKey.currentState;
            if(form.validate()){
              var email = _emailController.text;
              var password = _passwordController.text;

              var token =
                  await Provider.of<Login>(context).attemptLogin(email, password);
              if (token != null) {
                _writeToken(token);
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              } else {
                displayDialog(context, "Incorrect email or password",
                    "No account was found matching that email and password");
              }
            }
          },
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
          controller: _usernameController,
          decoration: new InputDecoration(labelText: 'Username'),
          validator: (value) {
            return value.isEmpty ? 'Username required' : null;
          },
        ),
        new RaisedButton(
          child: new Text("Create account", style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.purple,
          onPressed: () async {
            if(formKey.currentState.validate()){
              var email = _emailController.text;
              var password = _passwordController.text;
              var username = _usernameController.text;

              int res =
                  await Provider.of<Login>(context).attemptSignUp(email, password, username);
                  if(res==400)
                    displayDialog(context, "Unknown Error", "Some unknown error occured. Try again");
                  else if(res==200)
                    displayDialog(context, "Success", "The user was created. Log in now.");
                  else if(res==409)
                    displayDialog(context, "Error", "Please try to sign up using another username or log in if you already have an account.");  
            }
          },
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
    return new Padding(
      padding: EdgeInsets.all(10.0),
      child: CircleAvatar(
        radius: 110.0,
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  @override
  LoginScreenState createState() => LoginScreenState();
}
