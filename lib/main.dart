import './screens/bookmarks_screen.dart';
import './screens/explore_screen.dart';
import './screens/profile_page.dart';
import './screens/your_articles_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/article_page.dart';
import './providers/articles.dart';
import './screens/tabs_screen.dart';
import './screens/edit_profile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Articles(),
      child: MaterialApp(
          title: "Blogging App",
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: TabScreen(),
          routes: {
            TabScreen.routeName: (context) => TabScreen(),
            ProfilePage.routeName: (context) => ProfilePage(),
            ArticlePage.routeName: (context) => ArticlePage(),
            EditProfile.routeName: (context) => EditProfile(),
            BookmarkScreen.routeName: (context) => BookmarkScreen(),
            ExploreScreen.routeName: (context) => ExploreScreen(),
            YourArticles.routeName: (context) => YourArticles(),
          }),
    );
  }
}
