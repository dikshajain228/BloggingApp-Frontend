import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();
DateTime date;

class ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Title of the article',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.thumb_up,
            color: Colors.red[500],
          ),
          Text(' 41'),
        ],
      ),
    );

    //Color color = Theme.of(context).primaryColor;

    Widget articleTextSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //_buildButtonColumn(FlatButton (color, Icons.edit, 'EDIT',)),
          FlatButton(
            child: Text("EDIT"),
            onPressed: () {
              //sholud take to edit page
              Navigator.of(context).pop();
            },
          ),

          FlatButton(
            child: Text("DELETE"),
            onPressed: () {
              //Navigator.of(context).pop();
              onPressed:
              () => showAlert(context);
            },
          ),
        ],
      ),
    );

    Widget dateSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("Written On"),
          ),
          Container(
            child: Text(new DateFormat("dd-MM-yyyy").format(now)),
          ),
        ],
      ),
    );

    Widget commentSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              '  View Comments',
              style: TextStyle(
                  //color: Colors.grey[500],
                  ),
            ),
          ),
        ],
      ),
    );

    return MaterialApp(
      title: 'Article',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Article'),
        ),
        body: ListView(
          children: [
            titleSection,
            articleTextSection,
            buttonSection,
            dateSection,
            commentSection,
          ],
        ),
      ),
    );
  }

  //Has to be implemented in class AlertWithButtonsWidget extends State {}
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Dialog.'),
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
