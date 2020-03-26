import 'package:bloggingapp/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class UserPreviewCard extends StatelessWidget {
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
              user.profile_image_url,
              fit: BoxFit.cover,
              height: 50.0,
              width: 50.0,
            ),
          ),
          title: Text(
            user.username,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          trailing: user.is_following
                      ?
                      // is following
                      FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            user.followUnfollow();
                          },
                          child: Text("Following"),
                        )
                      // Follower
                      : OutlineButton(
                          color: Colors.blue,
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                          textColor: Colors.blue,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            user.followUnfollow();
                          },
                          child: Text("Follow"),
                        ),
          onTap: () {
            Navigator.of(context).pushNamed(
              UserProfilePage.routeName,
              arguments: user.user_id,
            );
          },
        ),
      ),
    );
  }
}