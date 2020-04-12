import 'package:bloggingapp/screens/article_delete_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import './screens/home_screen.dart';
import './screens/profile_edit_screen.dart';
import './screens/article_screen.dart';
import './screens/collection_screen.dart';
import './screens/bookmarks_screen.dart';
import './screens/explore_screen.dart';
import './screens/profile_screen.dart';
import './screens/article_insert_screen.dart';
import './screens/article_edit_screen.dart';
import './screens/collection_edit_screen.dart';
import './screens/collection_insert_screen.dart';
import './screens/login_screen.dart';
import './screens/user_screen.dart';
import './screens/change_password.dart';

// Providers
import './providers/articles.dart';
import './providers/collections.dart';
import './providers/users.dart';
import './providers/userAuthentication.dart';

import './route_observer.dart' as route_observer;
import './app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeObserver = route_observer.routeObserver;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        ),
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
        navigatorObservers: <NavigatorObserver>[routeObserver],
        title: "Blogging App",
        theme: AppTheme.lightTheme,
        // ThemeData(
        //   // primaryColor: Colors.teal,
        //   // accentColor: Colors.white60,
        //   // primarySwatch: Colors.purple,
        // ),
        home: LoginScreen(),
        routes: {
          ChangePassword.routeName: (context) => ChangePassword(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          //ProfileEProfileEditScreen.routeName: (context) => ProfileEProfileEditScreen(),
          BookmarkScreen.routeName: (context) => BookmarkScreen(),
          ExploreScreen.routeName: (context) => ExploreScreen(),
          // ArticleInsertScreen.routeName: (context) => ArticleInsertScreen(),
          //ArticleEditScreen.routeName: (context) => ArticleEditScreen(),
          //EditCollection.routeName: (context) => EditCollection(),
          CollectionInsertScreen.routeName: (context) =>
              CollectionInsertScreen(),
          ArticleDeleteScreen.routeName: (context) => ArticleDeleteScreen()
          // CollectionScreen.routeName: (context) => CollectionScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            CollectionScreen.routeName: (context) =>
                CollectionScreen(settings.arguments),
            EditCollection.routeName: (context) =>
                EditCollection(settings.arguments),
            ArticleEditScreen.routeName: (context) =>
                ArticleEditScreen(settings.arguments),
            ArticleScreen.routeName: (context) =>
                ArticleScreen(settings.arguments),
            ArticleInsertScreen.routeName: (context) =>
                ArticleInsertScreen(settings.arguments),
            ProfileEditScreen.routeName: (context) =>
                ProfileEditScreen(settings.arguments),
            UserScreen.routeName: (context) => UserScreen(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
      ),
    );
  }
}
