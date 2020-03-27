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

  new User(
       user_id: 2,
      email: "diksha7354@gmail.com",
      username: "diksha",
      about: "Lets's catch up to know more about me.",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ),
    new User(
       user_id: 3,
      email: "ananyasheshu@gmail.com",
      username: "ananya",
      about: "Sky is the limit.",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ),
    new User(
       user_id: 4,
      email: "pragatibattula@gmail.com",
      username: "pragati",
      about: "Whatever will be,will be",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ),
  ];
  List<User> get users{
    return [..._users];
  }


 /**Future<void> getUserProfile()async {
   List<User> fetchedData = [];
    fetchedData.add(User(user_id: 1,
        is_following: false,
        email: "nairanjali0508@gmail.com",
        username: "anjalay",
        about: "HElo gurls nd bois ssup with y'all. How is corona treating you? Hope all are infected",
        profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"));

    fetchedData.add(User(
      user_id: 2,
      is_following: false,
      email: "diksha7354@gmail.com",
      username: "diksha",
      about: "Lets's catch up to know more about me.",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ));
    fetchedData.add(User(
      user_id: 3,
      is_following: false,
      email: "ananyasheshu@gmail.com",
      username: "ananya",
      about: "Sky is the limit.",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    ));
     fetchedData.add(User(
      user_id: 4,
      is_following: false,
      email: "pragatibattula@gmail.com",
      username: "pragati",
      about: "Whatever will be,will be",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
     ));
  }**/

   User getUserProfile(){
    return User(
        user_id: 1,
        is_following: false,
        email: "nairanjali0508@gmail.com",
        username: "anjalay",
        about: "HElo gurls nd bois ssup with y'all. How is corona treating you? Hope all are infected",
        profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
      );
     return User(
      user_id: 2,
      is_following: false,
      email: "diksha7354@gmail.com",
      username: "diksha",
      about: "Lets's catch up to know more about me.",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    );
    return User(
      user_id: 3,
      is_following: false,
      email: "ananyasheshu@gmail.com",
      username: "ananya",
      about: "Sky is the limit.",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
    );
     return User(
      user_id: 4,
      is_following: false,
      email: "pragatibattula@gmail.com",
      username: "pragati",
      about: "Whatever will be,will be",
      profile_image_url: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk"
     );
  }
}
