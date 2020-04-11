import '../widgets/collection_list.dart';
import '../widgets/articles_list.dart';
import '../widgets/error_dialog.dart';

import '../providers/users.dart';
import '../providers/user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../route_observer.dart' as route_observer;

class UserScreen extends StatefulWidget {
  static const routeName = "/user";

  final String userId;
  UserScreen(this.userId);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with TickerProviderStateMixin, RouteAware {

  User user;
  TabController _tabController;

  bool _loadingUser = true;
  bool _error = false;
  bool _isInit = true;

  final routeObserver = route_observer.routeObserver;
  

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
    print("I am in view profile page");
  }

  @override
  void didChangeDependencies(){
    routeObserver.subscribe(this, ModalRoute.of(context));
    if(_isInit){
      _loadData();
      setState((){
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void didPopNext(){
    print("pop next");
    _loadData();
    super.didPopNext();
  }

  void _loadData(){
    Provider.of<Users>(context).fetchUserById(widget.userId).then((data){
      setState(() {
       _loadingUser = false;
       user = data; 
      });
    }).catchError((errorMessage){
            showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              errorMessage: errorMessage,
            );
          });
      setState((){
      _error = true;
      });
    });
    
  }
  

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text("Profile Page"),
              actions: <Widget>[
              
        ],
            ),
            body: (_loadingUser == true
          ? SpinKitChasingDots(
              color: Colors.teal,
            )
          :Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                          NetworkImage(user.profile_image_url),
                          radius: 60,
                        ),
                        new Text(
                          user.username,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold),
                        ),
                        new Text(user.about,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0)),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 6),
                          child: Container(
                            color: Colors.blueGrey[100],
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          user.followerCount.toString() + " followers",
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          user.followingCount.toString()+ " following",
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                            ),
                          ),
                        ),
                    user.is_following
                    ? FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        onPressed: () {
                          user.
                          unfollowUser(user.user_id.toString())
                              .then((_) {
                            print("Unfollowed user");
                          });
                        },
                        child: Text("Following"),
                      )
                    : OutlineButton(
                        color: Colors.blue,
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        textColor: Colors.blue,
                        padding: EdgeInsets.all(10.0),
                        onPressed: () {
                          user
                              .followUser(user.user_id.toString())
                              .then((_) {
                            print("Followed user");
                          });
                        },
                        child: Text("Follow"),
                      ),
                        new Container(
                          decoration: new BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .primaryColor),
                          child: new TabBar(controller: _tabController, tabs: [
                            Tab(text: "Articles"),
                            Tab(text: "Collections"),
                          ]),
                        ),
                        new Expanded(
                          child:TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                ArticlesList(),
                                CollectionList(),
                              ]),
                        )
                      ],
                    ),
                  ),
                ]
            )),
          ),

        ],
      );

  }
 }   
  