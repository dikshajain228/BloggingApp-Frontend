import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/opinion.dart';

class OpinionPreviewCard extends StatelessWidget {
  Widget build(BuildContext context) {
    final opinion = Provider.of<Opinion>(context);
    final photo = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: NetworkImage(opinion.user_profile_image_path),
        height: 60,
        width: 60,
      ),
    );
    final contentStyle = TextStyle(color: Colors.black, fontSize: 14.0);
    final usernameStyle = TextStyle(fontSize: 12.0, color: Colors.blue);
    final opinionDateStyle = TextStyle(fontSize: 12.0, color: Colors.black45);
    final card = new Container(
        margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 0.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: new Text(
                '@' + opinion.username,
                style: usernameStyle,
              ),
              onTap: () {},
            ),
            new Text(
              opinion.content,
              style: contentStyle,
            ),
            Row(
              children: <Widget>[
                new Text(
                  DateFormat.yMd()
                      .add_jm()
                      .format(opinion.opinion_date)
                      .toString(),
                  style: opinionDateStyle,
                ),
                new Text("  |  "),
                new Text(
                  "View Replies",
                  style: usernameStyle,
                )
              ],
            )
          ],
        ));
    return new Container(
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: Container(
        child: new Stack(
          children: <Widget>[card, photo, Divider()],
        ),
      ),
    );
  }
}
