import 'package:flutter/material.dart';
import './user.dart';

class Users with ChangeNotifier {
  List<User> _users =[
    new User(
      user_id: 1,
      email: "nairanjali0508@gmail.com",
      username: "anjalay",
      about: "HElo gurls nd bois ssup w y'all",
      is_following: false,
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ),
  ];
  List<User> get users{
    return [..._users];
  }
  User getUserProfile(){
    return User(user_id: 1,
        is_following: false,
        email: "nairanjali0508@gmail.com",
        username: "anjalay",
        about: "HElo gurls nd bois ssup with y'all. How is corona treating you? Hope all are infected",
        profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk");
  }
}