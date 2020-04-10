import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/collection_insert_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';

// Screens
import '../screens/profile_screen.dart';

class MainDrawer extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountEmail: null,
            accountName: null,
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.home),
              title: Text("Home Page"),
              onTap: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.bookmark),
              title: Text("Bookmarks"),
              onTap: () {
                Navigator.of(context).pushNamed(BookmarkScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.collections),
              title: Text(" Add Collections"),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(CollectionInsertScreen.routeName);
              }),
          ListTile(
              leading: Icon(Icons.explore),
              title: Text("Explore"),
              onTap: () {
                Navigator.of(context).pushNamed(ExploreScreen.routeName);
              }),
          Divider(),
          ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.cancel),
              onTap: () {
                storage.delete(key: "token");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login-screen', (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }
}
