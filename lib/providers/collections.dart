import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import './collection.dart';

class Collections with ChangeNotifier {
  List<Collection> _collections = [
    Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Stories through the eyes of a teenager",
      is_owner: "False",
      is_author: "False",
      is_following: "True",
    ),
    Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Stories through the eyes of a teenager",
      is_owner: "False",
      is_author: "False",
      is_following: "True",
    ),
    Collection(
      collection_id: "2",
      collection_name: "Personal Growth",
      user_id: 2,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Sharing our ideas and experiences.",
      is_owner: "True",
      is_author: "False",
      is_following: "False",
    ),
    Collection(
      collection_id: "3",
      collection_name: "Personal lala Growth",
      user_id: 3,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: "False",
      is_author: "True",
      is_following: "False",
    )
  ];

  List<Collection> get collections {
    return [...collections];
  }

  Collection findById(String collection_id) {
    return _collections
        .firstWhere((collection) => collection.collection_id == collection_id);
  }
}
