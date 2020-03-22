import 'package:bloggingapp/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:bloggingapp/providers/articles.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../widgets/articles_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List articles = [];
  final myTabs = [
    Tab(
      text: 'Articles',
    ),
    Tab(
      text: 'Questions',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Articles a = Articles();
    articles = a.articles;
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return pageHeader(context, controller, myTabs, articles);
  }
}

//Cant shift to new page because tab bar is a part of page screen
Widget pageHeader(BuildContext context, TabController controller, final myTabs,
    List articles) {
  //Header(appbar) with the tabs

  final storage = FlutterSecureStorage();

  return Scaffold(
    appBar: header("Blogging App"),
    body: ListView(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: TabBar(
            controller: controller,
            tabs: myTabs,
          ),
        ),
        Container(
          height: 542,
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              //POSTS
              Container(
                  child: articles.length == 0
                      ? Text("No Blog Post availabale")
                      : ArticlesList()),
              //QUESTIONS
              Container(
                child: Text("HEllo"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
