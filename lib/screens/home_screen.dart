import 'package:bloggingapp/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:bloggingapp/Posts.dart';
import 'package:bloggingapp/providers/articles.dart';
import 'package:bloggingapp/widgets/article_preview_card.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List articles = [];
  List<Posts> questions = [];
  final myTabs = [
    new Tab(
      text: 'Articles',
    ),
    new Tab(
      text: 'Questions',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Articles a = new Articles();
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
  return new Scaffold(
    appBar: header("Blogging App"),
    body: new ListView(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new TabBar(
            controller: controller,
            tabs: myTabs,
          ),
        ),
        new Container(
          height: 542,
          child: new TabBarView(
            controller: controller,
            children: <Widget>[
              //POSTS
              new Container(
                  child: articles.length == 0
                      ? new Text("No Blog Post availabale")
                      : new ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (_, index) {
                        return article_preview_card(
                          //List Tile cards
                            context,
                            articles[index].image_path,
                            articles[index].title,
                            articles[index].date_updated);
                      })),
              //QUESTIONS
              new Container(
                child: Text("HEllo"),),
            ],
          ),
        ),
      ],
    ),
  );
}


class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Page"),
      ),
      body: Center(
        child: Text('Page still under construction'),
      ),
    );
  }
}
