import '../screens/collection_insert_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Screens
import '../screens/profile_page.dart';

class MainDrawer extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.fill)),
            accountEmail: null,
            accountName: null,
          ),
          new ListTile(
              leading: Icon(Icons.person),
              title: new Text("Profile"),
              onTap: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.home),
              title: new Text("Home Page"),
              onTap: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.bookmark),
              title: new Text("Bookmarks"),
              onTap: () {
                Navigator.of(context).pushNamed(BookmarkScreen.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.collections),
              title: new Text(" Add Collections"),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(CollectionInsertScreen.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.explore),
              title: new Text("Explore"),
              onTap: () {
                Navigator.of(context).pushNamed(ExploreScreen.routeName);
              }),
          new Divider(),
          new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.cancel),
              onTap: () {
                storage.delete(key: "token");
                Navigator.of(context).pushNamedAndRemoveUntil('/login-screen', (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }
}
