import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

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
  bool _queryEntered = false;
  bool _loadingArticles = true;
  bool _loadingCollections = true;
  bool _loadingUsers = true;
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
    // to be removed
    Timer(Duration(seconds: 2), () {
      setState(() {
        searchStatus = SearchStatus.Searched;
      });
    });
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
                _queryEntered = true;
                searchStatus = SearchStatus.Searching;
                search();
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
                  _queryEntered = false;
                });
              },
            )
          ],
          bottom: (_queryEntered == false
              ? null
              : TabBar(controller: tabController, tabs: [
                  Tab(text: "Collections"),
                  Tab(text: "Articles"),
                  Tab(text: "People"),
                ])),
        ),
        body: (_queryEntered == false
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
            : (TabBarView(
                controller: tabController,
                children: <Widget>[
                  (_loadingCollections == true
                      ? SpinKitWanderingCubes(
                          color: Colors.teal,
                        )
                      : CollectionList()),
                  (_loadingArticles == true
                      ? SpinKitWanderingCubes(
                          color: Colors.teal,
                        )
                      : ArticlesList()),
                  (_loadingUsers == true
                      ? SpinKitWanderingCubes(
                          color: Colors.teal,
                        )
                      : UserList()),
                ],
              ))),
        drawer: MainDrawer());
  }
}
