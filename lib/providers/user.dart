import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final int user_id;
  final String email;
  String username;
  String about;
  String profile_image_url;
  bool is_following;
  User({@required this.user_id,
    @required this.email,
    @required this.username,
    @required this.about,
    @required this.profile_image_url,
    this.is_following,
  });
  
   void followUnfollow() {
    is_following = !is_following;
    notifyListeners();


  }


}
