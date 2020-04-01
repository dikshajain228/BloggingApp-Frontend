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
            onPressed:() => 
            showAlert(context),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleScreen.routeName,
                arguments: article.article_id);
          },
        ),
      ),
    );
  }

   showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Are You Sure Want To Delete?"),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                //Delete the article
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                //Stay on the same page
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
