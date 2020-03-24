import 'package:flutter/material.dart';
import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';

class YourArticles extends StatefulWidget {
  static const routeName = "/my-srticles-page";

  @override
  _YourArticlesState createState() => _YourArticlesState();
}

class _YourArticlesState extends State<YourArticles> {
  void initState() {
    print("HEllo I am in your srticles screen init state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Articles'),
      ),
      body: ArticlesList(),
      drawer: MainDrawer(),
    );
  }
}
