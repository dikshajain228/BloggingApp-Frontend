import './screens/home_screen.dart';
import 'package:flutter/material.dart';
import './screens/article_page.dart';
import './providers/articles.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Articles(),
      child: MaterialApp(
          title: "Blogging App",
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: MyHomePage(),
          routes: {
            ArticlePage.routeName: (context) => ArticlePage(),
          }),
    );
  }
}
