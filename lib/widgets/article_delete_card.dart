import 'package:flutter/material.dart';
import 'package:bloggingapp/screens/article_screen.dart';
import 'package:provider/provider.dart';

import '../providers/article.dart';
import '../providers/articles.dart';

class ArticleDeleteCard extends StatelessWidget {
  Article _article;

  Widget build(BuildContext context) {
    _article = Provider.of<Article>(context);

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
              _article.image_path,
              fit: BoxFit.cover,
              height: 50.0,
              width: 50.0,
            ),
          ),
          title: Text(
            _article.title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            _article.date_updated.toString(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                showAlert(context, _article.article_id, _article.title);
              }),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleScreen.routeName,
                arguments: _article.article_id);
          },
        ),
      ),
    );
  }

  showAlert(BuildContext context, article_id, title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          titlePadding: EdgeInsets.all(0),
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              'Delete Article...?',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
          content: Text("The _article titled - " +
              title +
              " will be deleted. This action cannot be undone. Confirm delete?"),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              child: Text("DELETE"),
              textColor: Theme.of(context).colorScheme.error,
              onPressed: () {
                _article.deleteArticle(article_id).then((_) {
                  print("Article deleted");
                });
                Provider.of<Articles>(context)
                    .deleteArticle(article_id)
                    .then((_) {
                  print("Deleted from list _article");
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: Text("CANCEL"),
              textColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
