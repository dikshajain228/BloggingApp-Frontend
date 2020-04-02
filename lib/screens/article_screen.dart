import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import './article_edit_screen.dart';

import '../providers/articles.dart';
import '../providers/article.dart';

class ArticleScreen extends StatefulWidget {
  static const routeName = "/article";

  String article_id;
  ArticleScreen({Key key, @required this.article_id}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState(article_id);
}

class _ArticleScreenState extends State<ArticleScreen>
    with SingleTickerProviderStateMixin {
  String article_id;
  Article article;
  bool is_author = true; // link to provider
  String content;
  NotusDocument document;

  _ArticleScreenState(this.article_id);

  @override
  void initState() {
    super.initState();
    print(this.article_id);

    content = jsonEncode([
      {"insert": "Enter content\nOMG "},
      {
        "insert": "please work",
        "attributes": {"i": true}
      },
      {"insert": "\n"},
      {
        "insert": "I'm tired",
        "attributes": {"b": true}
      },
      {"insert": "\nI'll cry now"},
      {
        "insert": "\n",
        "attributes": {"heading": 1}
      }
    ]);

    document = getContent();
  }

  @override
  void didChangeDependencies() {
    article = Provider.of<Articles>(context).findById(article_id);
    Provider.of<Articles>(context).getCollectionArticles(article_id);
    super.didChangeDependencies();
    print(article.title);
    getContent();
  }

  NotusDocument getContent() {
    dynamic documentData = jsonDecode(content);
    return NotusDocument.fromJson(documentData);

    // final Delta delta = Delta()..insert("Zefyr Quick Start\n");
    // return NotusDocument.fromDelta(delta);
    // print(NotusDocument.fromJson(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Article"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              child: Center(
                child: Text(
                  'Title of the article',
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
                child: Image.network(
                  article.image_path,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ZefyrView(
                document: document,
                // imageDelegate: CustomImageDelegate(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("Published on  "),
                  Text(DateFormat("dd-MM-yyyy").format(article.date_created)),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: this.is_author ? plusFloatingButton() : null);
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
          onTap: () =>
              {Navigator.of(context).pushNamed(ArticleEditScreen.routeName)},
        ),
      ],
    ));
  }
}
