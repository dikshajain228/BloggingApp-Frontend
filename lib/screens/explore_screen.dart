import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../route_observer.dart' as route_observer;

import '../widgets/drawer.dart';
import '../widgets/collection_list.dart';
import '../widgets/articles_list.dart';
import '../widgets/user_list.dart';

import '../providers/collections.dart';
import '../providers/articles.dart';
import '../providers/users.dart';

class ExploreScreen extends StatefulWidget {
  static const routeName = "/explore";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  bool _queryEntered = false;
  bool _loadingArticles = true;
  bool _loadingCollections = true;
  bool _loadingUsers = true;
  bool _errorArticles = false;
  bool _errorCollections = false;
  bool _errorUsers = false;
  String _query = "";
  TabController tabController;
  TextEditingController searchController;

  final routeObserver = route_observer.routeObserver;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    setState(() {
      _queryEntered = false;
    });
    super.didPopNext();
  }

  void search() {
    // Search collections
    Provider.of<Collections>(context).searchCollections(_query).then((_) {
      setState(() {
        _loadingCollections = false;
      });
    }).catchError((errorMessage) {
      _errorCollections = true;
    });
    // Search articles
    Provider.of<Articles>(context).searchArticles(_query).then((_) {
      setState(() {
        _loadingArticles = false;
      });
    }).catchError((errorMessage) {
      _errorArticles = true;
    });
    Provider.of<Users>(context).searchUsers(_query).then((_) {
      setState(() {
        _loadingUsers = false;
      });
    }).catchError((errorMessage) {
      _errorUsers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff191654),
                    Color(0xff43c6ac),
                    Color(0xff6dffe1),
                  ]),
            ),
          ),
          title: TextField(
            autofocus: false,
            controller: searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0x44ffffff),
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
              setState(() {
                _query = searchController.text;
                _queryEntered = true;
                search();
              });
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
                  _query = "";
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
                      image: ExactAssetImage("assets/images/person_search.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            : (TabBarView(
                controller: tabController,
                children: <Widget>[
                  (_errorCollections == true
                      ? Center(
                          child: Text("An error occured"),
                        )
                      : (_loadingCollections == true
                          ? SpinKitWanderingCubes(
                              color: Colors.teal,
                            )
                          : CollectionList())),
                  (_errorArticles == true
                      ? Center(
                          child: Text("An error occured"),
                        )
                      : (_loadingArticles == true
                          ? SpinKitWanderingCubes(
                              color: Colors.teal,
                            )
                          : ArticlesList())),
                  (_errorUsers == true
                      ? Center(
                          child: Text("An error occured"),
                        )
                      : (_loadingUsers == true
                          ? SpinKitWanderingCubes(
                              color: Colors.teal,
                            )
                          : UserList())),
                ],
              ))),
        drawer: MainDrawer());
  }
}
