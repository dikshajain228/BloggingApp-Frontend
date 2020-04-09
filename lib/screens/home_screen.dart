import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';

import '../providers/articles.dart';

import '../server_util.dart' as Server;

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

  // void _writeToken() async {
  //   final token =
  //       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo2LCJlbWFpbCI6ImFzaGxleUBnbWFpbC5jb20iLCJpYXQiOjE1ODU3OTk2NTgsImV4cCI6MTU4NzA5NTY1OH0.oMwuiyNYJmSP4UZhmeVRywWSo0CRX4xdkFLWgo-MSLI";
  //   await storage.write(key: "token", value: token);
  // final tokenPayload = token.split(".");
  // final payloadMap = jsonDecode(
  //     utf8.decode(base64Url.decode(base64Url.normalize(tokenPayload[1]))));
  // print(payloadMap);
  // await storage.write(key: "userId", value: payloadMap["user_id"].toString());
  // await storage.write(key: "email", value: payloadMap["email"]);
  // }

  @override
  void didChangeDependencies() {
    //_writeToken();
    _readToken();

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
    final response = await http.get(Server.SERVER_IP);
    //final response = await http.get(GlobalConfiguration().getString("SERVER_IP"));

    print("hello" + response.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f7f6),
      appBar: AppBar(
        title: Text('Home Screen'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xff191654),
                  Color(0xff43c6ac),
                  // Color(0xff6dffe1),
                  Color(0xff6dffe1),
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff43c6ac),
        splashColor: Color(0xff191654),
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: "Add Articles",
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
