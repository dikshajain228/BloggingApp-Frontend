import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';

import '../providers/articles.dart';
import '../providers/article.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-page";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  bool _isInit = true;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    print("Home page init now");
  }

  void _writeToken() async {
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo2LCJlbWFpbCI6ImFzaGxleUBnbWFpbC5jb20iLCJpYXQiOjE1ODU3OTk2NTgsImV4cCI6MTU4NzA5NTY1OH0.oMwuiyNYJmSP4UZhmeVRywWSo0CRX4xdkFLWgo-MSLI";
    await storage.write(key: "token", value: token);
    final tokenPayload = token.split(".");
    final payloadMap = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(tokenPayload[1]))));
    // print(payloadMap);
    await storage.write(key: "userId", value: payloadMap["user_id"].toString());
    await storage.write(key: "email", value: payloadMap["email"]);
  }

  @override
  void didChangeDependencies() {
    _writeToken();
    // _readToken();

    Provider.of<Articles>(context).getFeedArticles().then((_) {
      setState(() {
        _loading = false;
      });
    });

    super.didChangeDependencies();
  }

  // void _getArticles() async {
  //   await Provider.of<Articles>(context).getFeedArticles().then((_) {
  //     setState(() {
  //       _loading = false;
  //     });
  //   });
  // }

  void _readToken() async {
    String token = await storage.read(key: "token");
    print(token);
  }

  void _testRequest() async {
    final response = await http.get("http://10.0.2.2:3000");
    print(response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: (_loading == true
          ? SpinKitWanderingCubes(
              color: Theme.of(context).primaryColor,
            )
          :
          // (_articles.length == 0
          //     ? Center(
          //         child: Container(
          //           child: Text("Follow collections to view articles"),
          //         ),
          //       )
          ArticlesList()),
      drawer: MainDrawer(),
    );
  }
}
