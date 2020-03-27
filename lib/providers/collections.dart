import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import './collection.dart';

class Collections with ChangeNotifier {
  List<Collection> _collections = [
    Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url:
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      description: "Stories through the eyes of a teenager",
      is_owner: true,
      is_author: false,
      is_following: false,
    )
  ];

  List<Collection> get collections {
    return [..._collections];
  }

  Collection findById(String collection_id) {
    return _collections
        .firstWhere((collection) => collection.collection_id == collection_id);
  }

  void getCollections() {
    // Get data from server
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url:
          "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      description: "Stories through the eyes of a teenager",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));
    fetchedData.add(Collection(
      collection_id: "2",
      collection_name: "Personal Growth",
      user_id: 2,
      image_url:
          "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      description: "Sharing our ideas and experiences.",
      is_owner: true,
      is_author: false,
      is_following: false,
    ));
    fetchedData.add(Collection(
      collection_id: "3",
      collection_name: "Personal lala Growth",
      user_id: 3,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: false,
      is_author: true,
      is_following: false,
    ));

    _collections = fetchedData;
    // notifyListeners();
  }

  Collection getCollectionById(String collection_id) {
    List<Collection> fetchedData = [];
    fetchedData.add(Collection(
      collection_id: "1",
      collection_name: "storytellers",
      user_id: 1,
      image_url:
          "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      description: "Stories through the eyes of a teenager",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));
    fetchedData.add(Collection(
      collection_id: "2",
      collection_name: "Personal Growth",
      user_id: 2,
      image_url:
          "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      description: "Sharing our ideas and experiences.",
      is_owner: true,
      is_author: false,
      is_following: false,
    ));
    fetchedData.add(Collection(
      collection_id: "3",
      collection_name: "Personal lala Growth",
      user_id: 3,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "Haha idk ideas and experiences.",
      is_owner: false,
      is_author: true,
      is_following: false,
    ));
    // Make call to get a single collection
    return fetchedData
        .firstWhere((collection) => collection.collection_id == collection_id);
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
      is_owner: true,
      is_author: false,
      is_following: false,
    ));

    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "me me me",
      user_id: 5,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "all about me.",
      is_owner: true,
      is_author: false,
      is_following: false,
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
      is_owner: false,
      is_author: false,
      is_following: true,
    ));

    fetchedData.add(Collection(
      collection_id: "4",
      collection_name: "Everything",
      user_id: 4,
      image_url: "https://i.stack.imgur.com/l60Hf.png",
      description: "This that here there.",
      is_owner: false,
      is_author: false,
      is_following: true,
    ));

    _collections = fetchedData;
    notifyListeners();
  }

  Future<void> addCollection(Collection newCollection) async {}

  Future<void> updateCollection(String id, Collection newCollection) async {}

  Future<void> deleteCollection(String id) async {}
}
