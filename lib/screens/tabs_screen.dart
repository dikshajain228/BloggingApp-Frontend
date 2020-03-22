import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Articles",),
              Tab(text: "Questions",)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ArticlesList(),
            Text("Hello")
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
