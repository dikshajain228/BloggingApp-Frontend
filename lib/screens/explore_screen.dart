import 'package:bloggingapp/screens/explore_collection_list.dart';
import 'package:bloggingapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/articles_list.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = "/explore-screen";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  void initState() {
    print("I am in explore screen");
  }

  void populateData() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Explore'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                populateData;
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Users",
              ),
              Tab(
                text: "Collections",
              ),
              Tab(text: "Articles"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Text("yo"),
            CollectionList(),
            ArticlesList(),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
