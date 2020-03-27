import 'package:flutter/material.dart';
import './user.dart';

class Users with ChangeNotifier {
  List<User> _users =[
    new User(
      user_id: 1,
      email: "nairanjali0508@gmail.com",
      username: "anjalay",
      about: "HElo gurls nd bois ssup w y'allhbshdjabdch, jhbcjhsbcjf hjcbjhsdb cf uhfjesbnfk?",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ),
  ];
  List<User> get users{
    return [..._users];
  }
  User getUserProfile(){
    return User(user_id: 1,
        email: "nairanjali0508@gmail.com",
        username: "anjalay",
        about: "HElo gurls nd bois ssup w y'alljncjzdc ukjncjdsnv jcbjdsb cfn jbcjdsbk iujcnjdsbnc?",
        profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk");
  }
}