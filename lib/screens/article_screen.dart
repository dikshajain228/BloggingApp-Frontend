import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './article_edit_screen.dart';

import '../providers/articles.dart';
import '../providers/article.dart';

class ArticleScreen extends StatefulWidget {
  static const routeName = "/article";

  String articleId;
  ArticleScreen(this.articleId);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with SingleTickerProviderStateMixin {
  Article _article;
  bool _loading = true;
  NotusDocument _content;

  @override
  void initState() {
    super.initState();

    // content = jsonEncode([
    //   {"insert": "Enter content\nOMG "},
    //   {
    //     "insert": "please work",
    //     "attributes": {"i": true}
    //   },
    //   {"insert": "\n"},
    //   {
    //     "insert": "I'm tired",
    //     "attributes": {"b": true}
    //   },
    //   {"insert": "\nI'll cry now"},
    //   {
    //     "insert": "\n",
    //     "attributes": {"heading": 1}
    //   }
    // ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Articles>(context)
        .getArticleById(widget.articleId)
        .then((article) {
      print("Got article");
      setState(() {
        _loading = false;
        _article = article;
        _content = getContent();
      });
    });
  }

// Rename
  NotusDocument getContent() {
    var data = jsonDecode(_article.content);
    return NotusDocument.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Article"),
        ),
        body: (_loading == true
            ? SpinKitChasingDots(
                color: Colors.teal,
              )
            : Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 10,
                    ),
                    child: Center(
                      child: Text(
                        _article.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: _article.image_path,
                        placeholder: (context, url) => Image.network(
                          "http://via.placeholder.com/640x360",
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        errorWidget: (context, url, error) => Image.network(
                          "http://via.placeholder.com/640x360",
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ZefyrView(
                      document: _content,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Published on  "),
                        Text(DateFormat("dd-MM-yyyy")
                            .format(_article.date_created)),
                      ],
                    ),
                  ),
                ],
              )),
        floatingActionButton: _article.is_author ? plusFloatingButton() : null);
  }

  // Floating button for authors
  Widget plusFloatingButton() {
    return (SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(),
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => {},
      onClose: () => {},
      tooltip: 'Options',
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 10.0,
      children: [
        SpeedDialChild(
          child: Icon(Icons.delete_sweep),
          backgroundColor: Colors.tealAccent,
          label: 'Delete Article',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {},
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Colors.tealAccent,
          label: 'Edit Article',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleEditScreen.routeName);
          },
        ),
      ],
    ));
  }
}
