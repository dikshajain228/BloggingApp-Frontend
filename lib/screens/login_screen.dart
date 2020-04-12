import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

import '../providers/userAuthentication.dart';

import '../app_theme.dart';

import '../screens/home_screen.dart';

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String formType = "login";

  final storage = FlutterSecureStorage();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void initState() {
    print("I am in login screen");
    super.initState();
  }

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
    //print(payloadMap);
    await storage.write(key: "userId", value: payloadMap["user_id"].toString());
    await storage.write(key: "email", value: payloadMap["email"]);
  }

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
    return Scaffold(
      appBar: AppBar(
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
        title: Text("Flutter Blog App"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            autovalidate: true,
            child: Column(
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
      TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value.isEmpty)
            return 'Email required';
          else {
            Pattern pattern = r"[A-Za-z0-9]*@[A-Za-z]+.[a-zA-Z]{2,}";
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value))
              return 'Enter valid Email';
            else
              return null;
          }
          return null;
        },
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            var err = null;
            if (value.isEmpty) err = 'Password required';
            // else if(value.length<8) err='Password length should not be less than 8';
            return err;
          },
        ),
      ),
    ];
  }

  List<Widget> createButtons() {
    if (formType == "login") {
      return [
        RaisedButton(
          child: Text("Login", style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            final form = formKey.currentState;
            if (form.validate()) {
              var email = _emailController.text;
              var password = _passwordController.text;

              var token = await Provider.of<Authentication>(context)
                  .attemptLogin(email, password);
              // String username =
              //     Provider.of<Authentication>(context).getUsername();
              //print("hello" + username);
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
        FlatButton(
          child: Text("Dont have an account? Create Account?",
              style: TextStyle(fontSize: 14.0)),
          textColor: Colors.deepPurple,
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(labelText: 'Username'),
          validator: (value) {
            return value.isEmpty ? 'Username required' : null;
          },
        ),
        RaisedButton(
          child: Text("Create account", style: TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            if (formKey.currentState.validate()) {
              var email = _emailController.text;
              var password = _passwordController.text;
              var username = _usernameController.text;

              int res = await Provider.of<Authentication>(context)
                  .attemptSignUp(email, password, username);
              if (res == 400)
                displayDialog(
                    context, "Error", "Required information is incomplete");
              else if (res == 200)
                displayDialog(
                    context, "Success", "The user was created. Log in now.");
              else if (res == 409)
                displayDialog(context, "Error",
                    "Please try to sign up using another username or log in if you already have an account.");
              else
                displayDialog(context, "Error", "Unknown error");
            }
          },
        ),
        FlatButton(
          child:
              Text("Have an account? Login", style: TextStyle(fontSize: 14.0)),
          textColor: Colors.deepPurple,
          onPressed: moveToLogin,
        )
      ];
    }
  }

  Widget logo() {
    return Padding(
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
