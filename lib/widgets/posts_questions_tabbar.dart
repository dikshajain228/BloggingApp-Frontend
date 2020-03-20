import 'package:flutter/material.dart';
import 'package:bloggingapp/widgets/article_preview_card.dart';

ListView posts_questions_tabbar(BuildContext context, TabController controller,
    List articles, final myTabs) {
  return ListView(
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
              child: Text("Page still under construction"),
            ),
          ],
        ),
      ),
    ],
  );
}
