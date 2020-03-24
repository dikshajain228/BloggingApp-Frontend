import 'package:flutter/material.dart';
import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = "/bookmark-page";

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {

  void initState(){
    print("HEllo I am in bookmarks init state");
  }
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
