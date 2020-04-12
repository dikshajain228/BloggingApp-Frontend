import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../route_observer.dart' as route_observer;

import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';
import '../widgets/error_dialog.dart';

import '../providers/articles.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-page";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  bool _loading = true;
  bool _isInit = true;
  bool _error = false;

  final routeObserver = route_observer.routeObserver;

  @override
  void initState() {
    super.initState();
    print("Home page init now");
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    if (_isInit) {
      _loadData();
      setState(() {
        _isInit = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    _loadData();
    super.didPopNext();
  }

  void _loadData() {
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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f7f6),
      appBar: AppBar(
        title: Text('Feed'),
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
      ),
      body: (_error == false
          ? (_loading == true
              ? SpinKitWanderingCubes(
                  color: Theme.of(context).primaryColor,
                )
              : ArticlesList())
          : Center(
              child: Text("An error occured..."),
            )),
      drawer: MainDrawer(),
    );
  }
}
