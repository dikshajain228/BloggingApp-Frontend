import 'package:flutter/material.dart';
import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';

class BookmarkScreen extends StatelessWidget {
  static const routeName = "/bookmark-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: ArticlesList(),
      drawer: MainDrawer(),
    );
  }
}
