import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../providers/articles.dart';

import '../widgets/drawer.dart';
import '../widgets/collection_list.dart';
import '../widgets/articles_list.dart';
import '../widgets/user_list.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = "/explore";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

enum SearchStatus { NoQuery, Searching, Searched }

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  TabController tabController;
  TextEditingController searchController;

  String searchText;

  SearchStatus searchStatus;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    searchController = TextEditingController();
    searchText = "";
    searchStatus = SearchStatus.NoQuery;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void search() {
    Provider.of<Collections>(context).getCollections();
    Provider.of<Articles>(context).getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            autofocus: false,
            controller: searchController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.teal[400],
              hintText: "Search...",
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (text) {
              // send a query
              setState(() {
                searchText = searchController.text;
                searchStatus = SearchStatus.Searching;
              });
              print(text);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {
                searchController.text = "";
                setState(() {
                  searchText = "";
                });
              },
            )
          ],
          bottom: (searchText == ""
              ? null
              : TabBar(controller: tabController, tabs: [
                  Tab(text: "Collections"),
                  Tab(text: "Articles"),
                  Tab(text: "People"),
                ])),
        ),
        body: (searchStatus == SearchStatus.NoQuery
            ? Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          ExactAssetImage("assests/images/person_search.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            : TabBarView(
                controller: tabController,
                children: <Widget>[
                  CollectionList(),
                  ArticlesList(),
                  UserList(),
                ],
              )),
        drawer: MainDrawer());
  }
}
