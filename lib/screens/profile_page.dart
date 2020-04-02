import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../screens/edit_profile_screen.dart';

import '../widgets/collection_list.dart';
import '../widgets/articles_list.dart';

import '../providers/users.dart';
import '../providers/user.dart';
import '../providers/articles.dart';
import '../providers/collections.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

List<Choice> choices = <Choice>[
  Choice(title: 'Edit Profile', icon: Icons.person),
  Choice(title: 'Change Password', icon: Icons.vpn_key),
];

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool _loadingProfile = true;
  bool _loadingArticles = true;
  bool _loadingCollections = true;
  User _user;

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
    print("I am in profile page");
  }

  @override
  void didChangeDependencies() {
    // Get profile details
    Provider.of<User>(context).getProfile().then((data) {
      setState(() {
        _loadingProfile = false;
        _user = data;
      });
    });

    // Get authored articles
    Provider.of<Articles>(context).getUserArticles().then((_) {
      setState(() {
        _loadingArticles = false;
      });
    });

    // Get owned / authored collections
    Provider.of<Collections>(context).getUserCollections().then((_) {
      setState(() {
        _loadingCollections = false;
      });
      print("Got collections");
    });

    super.didChangeDependencies();
  }

  Choice _selectedChoice = choices[0]; // The app's "state".
  void _select(Choice choice) {
    if (_selectedChoice == choices[0]) {
      Navigator.of(context).pushNamed(
        EditProfile.routeName,
        arguments: "1",
      );
    }
    if (_selectedChoice == choices[1]) {
      //dialog box to change password.
    }

    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            PopupMenuButton<Choice>(
              elevation: 3.2,
              onCanceled: () {},
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(0).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: (_loadingProfile == true
            ? SpinKitChasingDots(
                color: Colors.teal,
              )
            : Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_user.profile_image_url),
                          radius: 60,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
                            child: Text(
                              _user.username,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
                            child: Text(
                              _user.email,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      _user.about,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    color: Colors.teal[100],
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _user.followerCount.toString() + " followers",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
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
                                  _user.followingCount.toString() +
                                      " following",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor),
                    child: new TabBar(controller: _tabController, tabs: [
                      Tab(text: "Articles"),
                      Tab(text: "Collections"),
                    ]),
                  ),
                  new Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          (_loadingArticles == true
                              ? SpinKitDoubleBounce(
                                  color: Colors.teal,
                                )
                              : ArticlesList()),
                          (_loadingCollections == true
                              ? SpinKitFadingGrid(
                                  color: Colors.teal,
                                )
                              : CollectionList()),
                        ]),
                  )
                ],
              )));
  }
}

//Choice class
class Choice {
  Choice({this.title, this.icon});
  String title;
  IconData icon;
}
