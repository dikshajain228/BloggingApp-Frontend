import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../providers/articles.dart';

import '../widgets/drawer.dart';
import '../widgets/collection_list.dart';
import '../widgets/articles_list.dart';

class CollectionTestScreen extends StatefulWidget {
  static const routeName = "/tester";
  @override
  _CollectionTestScreenState createState() => _CollectionTestScreenState();
}

class _CollectionTestScreenState extends State<CollectionTestScreen>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    print("Collection");
  }

  @override
  void didChangeDependencies() {
    Provider.of<Collections>(context).getCollections();
    Provider.of<Articles>(context).getArticles();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Collections tester"),
            bottom: TabBar(controller: tabController, tabs: [
              Tab(text: "Collections"),
              Tab(text: "Articles"),
              Tab(text: "People"),
            ])),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            CollectionList(),
            ArticlesList(),
            Text("Users go here"),
          ],
        ),
        drawer: MainDrawer());
  }
}
