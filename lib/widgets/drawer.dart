import '../screens/bookmarks_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/your_articles_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import '../screens/profile_page.dart';
import '../screens/article_insert_screen.dart';
import '../screens/article_edit_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName:
                new Text("someusername"), //has to come  from login screen.
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              ),
              onTap: () => print("This is the current user."),
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        "https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.fill)),
            accountEmail: null,
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
                Navigator.of(context).pushNamed(TabScreen.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.bookmark),
              title: new Text("Bookmarks"),
              onTap: () {
                Navigator.of(context).pushNamed(BookmarkScreen.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.collections),
              title: new Text("Collections"),
              onTap: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.explore),
              title: new Text("Explore"),
              onTap: () {
                Navigator.of(context).pushNamed(ExploreScreen.routeName);
              }),
          new ListTile(
              leading: Icon(Icons.library_books),
              title: new Text("Your Articles"),
              onTap: () {
                Navigator.of(context).pushNamed(YourArticles.routeName);
              }),
          ListTile(
            title: Text("New article - delete"),
            onTap: () {
              Navigator.of(context).pushNamed(ArticleInsertScreen.routeName);
            },
          ),
          ListTile(
            title: Text("Edit article"),
            onTap: () {
              Navigator.of(context).pushNamed(ArticleEditScreen.routeName);
            },
          ),
          new Divider(),
          new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.cancel),
              onTap: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              }),
        ],
      ),
    );
  }
}
