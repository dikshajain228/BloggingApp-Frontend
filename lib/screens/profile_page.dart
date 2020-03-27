import '../widgets/collection_list.dart';
import '../widgets/articles_list.dart';
import '../providers/users.dart';
import '../providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile-page";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    super.initState();
    print("I am in profile page");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context).getUserProfile();
    print(user.about);
    double screenSize = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text("Profile Page"),
            ),
            body: Stack(
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
                        Container(
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
                                        "1011" + " followers",
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
                                        "1078" + " following",
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
            ),
          ),

        ],
      ),
    );
  }
}
