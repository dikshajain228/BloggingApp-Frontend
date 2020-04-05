import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';

import '../constants.dart' as Constants;

import '../screens/home_screen.dart';

const SERVER_IP = Constants.SERVER_IP;
final storage = FlutterSecureStorage();

class LoginScreenState extends State<LoginScreen> {
  
  

  final formKey = new GlobalKey<FormState>();
  String formType = "login";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> attemptLogin(String email, String password) async {
    try {
      var res = await http.post(
        "$SERVER_IP/api/v1/login",
        body: {"email": email, "password": password},
      );
      final resJson = json.decode(res.body);
      print(Constants.SERVER_IP+"jajajaja");
      print("Length" + resJson.length.toString());
      print(resJson);
      if (resJson.length == 1) {
        return null;
      }
      return resJson["token"];
    } catch (error) {
      throw error;
    }
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
          return value.isEmpty ? 'Email required' : null;
        },
      ),
    
      new Padding(
        padding:EdgeInsets.symmetric(vertical: 20.0),
        child:TextFormField(
        controller: _passwordController,
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password required' : null;
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
            var email = _emailController.text;
            var password = _passwordController.text;

            var token = await attemptLogin(email, password);
            if (token != null) {
              storage.write(key: "token", value: token);
              print(token);
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            } else {
              displayDialog(context, "Incorrect email or password",
                  "No account was found matching that email and password");
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
          decoration: new InputDecoration(labelText: 'Username'),
          validator: (value) {
            return value.isEmpty ? 'Username required' : null;
          },
        ),
        new RaisedButton(
          child: new Text("Create account", style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.purple,
          onPressed: () {},
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
      child:CircleAvatar(
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
