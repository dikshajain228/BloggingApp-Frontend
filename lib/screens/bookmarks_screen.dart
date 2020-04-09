import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../widgets/articles_list.dart';
import '../widgets/drawer.dart';
import '../widgets/error_dialog.dart';

import '../providers/articles.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = "/bookmark-page";

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  bool _loading = true;
  bool _error = false;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Articles>(context).getBookmarkedArticles().then((_) {
        setState(() {
          _loading = false;
        });
      }).catchError((errorMessage) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                errorMessage: errorMessage,
              );
            });
        setState(() {
          _error = true;
        });
      });
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookmarks'),
      ),
      body: (_error == true
          ? Text("An error occured")
          : (_loading == true
              ? SpinKitPulse(
                  color: Colors.teal,
                )
              : ArticlesList())),
      drawer: MainDrawer(),
    );
  }
}
