import 'package:flutter/material.dart';
import 'package:bloggingapp/screens/article_screen.dart';
import 'package:provider/provider.dart';
import '../providers/article.dart';

class ArticleDeleteCard extends StatelessWidget {
  Widget build(BuildContext context) {
    final article = Provider.of<Article>(context);

    return new Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: ClipOval(
            child: Image.network(
              article.image_path,
              fit: BoxFit.cover,
              height: 50.0,
              width: 50.0,
            ),
          ),
          title: Text(
            article.title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(article.date_updated.toString(),
              style: TextStyle(color: Colors.black)),
          trailing: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              handleOnPressed();
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleScreen.routeName,
                arguments: article.article_id);
          },
        ),
      ),
    );
  }

  AlertDialog handleOnPressed() {
    return AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure you want to delete this article?"),
      actions: <Widget>[
        FlatButton(child: const Text("No"), onPressed: () {}),
        FlatButton(child: const Text("Yes"), onPressed: () {}),
      ],
      elevation: 24.0,
      backgroundColor: Colors.white,
    );
  }
}
