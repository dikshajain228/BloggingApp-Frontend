import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
class TabScreen extends StatefulWidget {
  static const routeName = "/home-page";
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override

  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: ArticlesList(),
        drawer: MainDrawer(),
      );

  }
}
