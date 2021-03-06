import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/collection_insert_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

import '../providers/userAuthentication.dart';

class MainDrawer extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Authentication>(context);
    final username = user.username;
    final email = user.email;
    final profileImageUrl = user.profileImageUrl;

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            // currentAccountPicture: CircleAvatar(
            //   backgroundColor: Theme.of(context).colorScheme.secondary,
            //   backgroundImage: (profileImageUrl != null
            //       ? NetworkImage(profileImageUrl)
            //       : null),
            // child: Text(
            //   username[0].toUpperCase(),
            //   // "A",
            //   style: TextStyle(
            //     fontSize: 30,
            //     color: Theme.of(context).colorScheme.onSecondary,
            //   ),
            // ),
            // ),
            accountEmail: Text("email"),
            accountName: Text("username"),
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
