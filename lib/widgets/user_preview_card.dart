import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

import '../screens/user_screen.dart';

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
           leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: NetworkImage(user.profile_image_url),
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
                          color: Theme.of(context).colorScheme.primary,
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            user.
                          unfollowUser(user.user_id.toString())
                              .then((_) {
                            print("Unfollowed user");
                          });
                          },
                          child: Text("Following"),
                        )
                      // Follower
                      : OutlineButton(
                          color: Theme.of(context).colorScheme.primary,
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textColor: Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {
                            user
                              .followUser(user.user_id.toString())
                              .then((_) {
                            print("Followed user");
                            });
                          },
                          child: Text("Follow"),
                        ),
          onTap: () {
            Navigator.of(context).pushNamed(
             UserScreen.routeName,
              arguments: user.user_id.toString(),
           );
          },
        ),
      ),
    );
  }
}