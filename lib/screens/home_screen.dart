import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';
import '../widgets/error_dialog.dart';

import '../providers/articles.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-page";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  bool _isInit = true;
  bool _error = false;

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    print("Home page init now");
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Articles>(context).getFeedArticles().then((_) {
        setState(() {
          _loading = false;
        });
      }).catchError((errorMessage) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                errorMessage: errorMessage,
              );
            });
        setState(() {
          _error = true;
        });
      });
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: (_error == false
          ? (_loading == true
              ? SpinKitWanderingCubes(
                  color: Theme.of(context).primaryColor,
                )
              : ArticlesList())
          : Text("An error occured...")),
      drawer: MainDrawer(),
    );
  }
}
