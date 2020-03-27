import 'package:flutter/material.dart';
import './opinion.dart';

class Opinions with ChangeNotifier{
  List<Opinion> _opinions = [
    new Opinion(
      opinion_id: "1",
      article_id: "1",
      username: "anjali",
      content: "Wonderful article so proud of you my babies there us so much in this workd for you to see i dont know why am i doing this but i just want to see if it overflows",
      opinion_date: DateTime.parse("1969-07-20 20:18:04Z"),
      user_profile_image_path: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk",

    ),
    new Opinion(
      opinion_id: "1",
      article_id: "1",
      username: "anjali",
      content: "Wonderful article",
      opinion_date: DateTime.parse("1969-07-20 20:18:04Z"),
      user_profile_image_path: "https://media-exp1.licdn.com/dms/image/C5103AQHBDtEzuau2rA/profile-displayphoto-shrink_200_200/0?e=1590624000&v=beta&t=ZhtIT5ULua7ZmYzouKF2j4wHzTbFLdbxMcVTRjDHKFk",
    ),
    new Opinion(
      opinion_id: "1",
      article_id: "1",
      username: "nitesh",
      content: "You suck yo why you even doimg this",
      opinion_date: DateTime.parse("2020-07-20 20:18:04Z"),
      user_profile_image_path: "https://media-exp1.licdn.com/dms/image/C5103AQGDxa-dvHX5eQ/profile-displayphoto-shrink_800_800/0?e=1590624000&v=beta&t=vWGIOS-ZkaM6DzyWhgs70OipVbqTfFfKoFQPndpIkvk",
    )
  ];
  List<Opinion> get opinions{
    return [..._opinions];
  }

}