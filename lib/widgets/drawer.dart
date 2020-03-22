import 'package:flutter/material.dart';
import '../screens/profile_page.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("someusername"),//has to come  from login screen.
            currentAccountPicture: new GestureDetector(
              child: new CircleAvatar(
                backgroundImage: new NetworkImage("https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              ),
              onTap: () => print("This is the current user."),
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage("https://images.pexels.com/photos/414171/pexels-photo-414171.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.fill
                )
            ), accountEmail: null,
          ),

          new ListTile(
              leading: Icon(Icons.person),
              title: new Text("Profile"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }
          ),

          new ListTile(
              leading: Icon(Icons.home),
              title: new Text("Home Page"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));//change to home page from profile page
              }
          ),

          new ListTile(
              leading: Icon(Icons.bookmark),
              title: new Text("Bookmarks"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));//change to bookmarks page from profile page
              }
          ),

          new ListTile(
              leading: Icon(Icons.collections),
              title: new Text("Collections"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));//change to collections page from profile page
              }
          ),

          new ListTile(
              leading: Icon(Icons.explore),
              title: new Text("Explore"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));//change to articles page from profile page
              }

          ),


          new ListTile(
              leading: Icon(Icons.library_books),
              title: new Text("Your Articles"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));//change to articles page from explore page
              }

          ),

          new Divider(),

          new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.cancel),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));//change to login page from profile page
              }
          ),

        ],

      ),
    );
  }
}
