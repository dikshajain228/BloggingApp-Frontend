import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';

import '../providers/articles.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = "/bookmark-page";

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Articles>(context).getBookmarkedArticles().then((_) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookmarks'),
      ),
      body: (_loading == true
          ? SpinKitPulse(
              color: Colors.teal,
            )
          : ArticlesList()),
      drawer: MainDrawer(),
    );
  }
}
