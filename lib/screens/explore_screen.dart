import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../providers/articles.dart';

import '../widgets/drawer.dart';
import '../widgets/collection_list.dart';
import '../widgets/user_list.dart';
import '../widgets/articles_list.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = "/explore";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
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
            title: Text("Explore"),
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
            UserList(),
          ],
        ),
        drawer: MainDrawer());
  }
}
