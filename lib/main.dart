import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import './screens/tabs_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/article_screen.dart';
import './screens/collection_screen.dart';
import './screens/bookmarks_screen.dart';
import './screens/explore_screen.dart';
import './screens/profile_page.dart';
import './screens/your_articles_screen.dart';
import './screens/article_insert_screen.dart';
import './screens/article_edit_screen.dart';
import './screens/collection_edit_screen.dart';
import './screens/collection_insert_screen.dart';
import './screens/article_test_screen.dart';

// Providers
import './providers/articles.dart';
import './providers/collections.dart';
import './providers/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: Articles(),
        ),
        ChangeNotifierProvider.value(
          value: Collections(),
        )
      ],
      child: MaterialApp(
        title: "Blogging App",
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.white60,
          primarySwatch: Colors.purple,
        ),
        home: TabScreen(),
        routes: {
          TabScreen.routeName: (context) => TabScreen(),
          ProfilePage.routeName: (context) => ProfilePage(),
          ArticleScreen.routeName: (context) => ArticleScreen(),
          EditProfile.routeName: (context) => EditProfile(),
          BookmarkScreen.routeName: (context) => BookmarkScreen(),
          ExploreScreen.routeName: (context) => ExploreScreen(),
          YourArticles.routeName: (context) => YourArticles(),
          ArticleInsertScreen.routeName: (context) => ArticleInsertScreen(),
          ArticleEditScreen.routeName: (context) => ArticleEditScreen(),
          EditCollection.routeName: (context) => EditCollection(),
          CollectionInsertScreen.routeName: (context) =>
              CollectionInsertScreen(),
          // CollectionScreen.routeName: (context) => CollectionScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            CollectionScreen.routeName: (context) =>
                CollectionScreen(settings.arguments),
            ArticleScreenTest.routeName: (context) =>
                ArticleScreenTest(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
      ),
    );
  }
}
