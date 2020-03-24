import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import './collection.dart';

class Collections with ChangeNotifier {
  List<Collection> _collections = [];

  List<Collection> get collections {
    return [..._collections];
  }

  Collection findById(String collection_id) {
    return _collections
        .firstWhere((collection) => collection.collection_id == collection_id);
  }

  Future<void> getCollections() async {
    // Get data from server
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Stories through the eyes of a teenager",
      is_owner: "False",
      is_author: "False",
      is_following: "True",
    ));
    fetchedData.add(Collection(
      collection_id: "2",
      collection_name: "Personal Growth",
      user_id: 2,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Sharing our ideas and experiences.",
      is_owner: "True",
      is_author: "False",
      is_following: "False",
    ));
    fetchedData.add(Collection(
      collection_id: "3",
      collection_name: "Personal lala Growth",
      user_id: 3,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: "False",
      is_author: "True",
      is_following: "False",
    ));

    _collections = fetchedData;
    notifyListeners();
  }

  Future<void> getUsersCollections() async {
    // Pass token from local storage
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "Personal lala Growth",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: "True",
      is_author: "False",
      is_following: "False",
    ));

    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "me me me",
      user_id: 5,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "all about me.",
      is_owner: "True",
      is_author: "False",
      is_following: "False",
    ));

    _collections = fetchedData;
    notifyListeners();
  }

  Future<void> getFollowingCollection() async {
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "6",
      collection_name: "haha 123 haha",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "lalalalalala.",
      is_owner: "False",
      is_author: "False",
      is_following: "True",
    ));

    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "Everything",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "This that here there.",
      is_owner: "False",
      is_author: "False",
      is_following: "True",
    ));

    _collections = fetchedData;
    notifyListeners;
  }

  Future<void> addCollection(Collection newCollection) async {}

  Future<void> updateCollection(String id, Collection newCollection) async {}

  Future<void> deleteCollection(String id) async {}
}
