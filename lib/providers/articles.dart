import 'package:flutter/widgets.dart';
import './article.dart';

class Articles with ChangeNotifier {
  List<Article> _articles = [
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "2",
        collection_id: "2",
        user_id: 1,
        title: "I am sad",
        content: "bjhcbjhgfhgdfhvds",
        published: false,
        image_path:
            "https://images.pexels.com/photos/321470/pexels-photo-321470.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "2",
        collection_id: "2",
        user_id: 1,
        title: "I am sad",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),
    new Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
        "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false),


  ];

  Article findById(String article_id) {
    return _articles.firstWhere((article) => article.article_id == article_id);
  }

  List<Article> get articles {
    return [..._articles];
  }

  void getArticles() {
    List<Article> fetchedData = [];
    fetchedData.add(Article(
        article_id: "4",
        collection_id: "2",
        user_id: 1,
        title: "I am happy",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false));
    fetchedData.add(Article(
      article_id: "4",
      collection_id: "2",
      user_id: 1,
      title: "I am happy",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
          "https://pixabay.com/get/52e9d0454f51af14f6d1867dda35367b1d3adfe151547548_1920.jpg",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ));
    fetchedData.add(Article(
      article_id: "10",
      collection_id: "2",
      user_id: 1,
      title: "Me and everything else",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
          "https://pixabay.com/get/52e9d0454f51af14f6d1867dda35367b1d3adfe151547548_1920.jpg",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ));
    _articles = fetchedData;
  }

  void getCollectionArticles(String collectionId) {
    List<Article> fetchedData = [];
    fetchedData.add(Article(
        article_id: "4",
        collection_id: "2",
        user_id: 1,
        title: "I am happy - collection 1",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false));
    fetchedData.add(Article(
      article_id: "4",
      collection_id: "2",
      user_id: 1,
      title: "I am Collection 1",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
          "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ));
    fetchedData.add(Article(
      article_id: "10",
      collection_id: "2",
      user_id: 1,
      title: "Me and Collection 1",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
          "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ),

    );
    fetchedData.add(Article(
      article_id: "10",
      collection_id: "2",
      user_id: 1,
      title: "Me and Collection 1",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ),

    );
    fetchedData.add(Article(
      article_id: "10",
      collection_id: "2",
      user_id: 1,
      title: "Me and Collection 1",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ),

    );
    fetchedData.add(Article(
      article_id: "10",
      collection_id: "2",
      user_id: 1,
      title: "Me and Collection 1",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ),

    );
    _articles = fetchedData;
  }

  void editArticles() {
    notifyListeners();
  }
  
 Future<void> addarticle(Article newArticle) async {
         
    List<Article> fetchedData = [];
    fetchedData.add(Article(
      article_id: "11",
      collection_id: "2",
      user_id: 1,
      title: "Article11",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ));

    fetchedData.add(Article(
      article_id: "12",
     collection_id: "2",
      user_id: 1,
      title: "Article12",
      content: "bjhcbjhgfhgdfhvds",
      published: true,
      image_path:
      "https://images.pexels.com/photos/531602/pexels-photo-531602.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      views_count: 0,
      kudos_count: 0,
      date_created: DateTime.parse("1969-07-20 20:18:04Z"),
      date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
      bookmarked: false,
    ));
    _articles = fetchedData;
    notifyListeners();
  }
  Future<void> updateArticle(String id) async {
    List<Article> fetchedData = [];
        fetchedData.add(Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false,
    ));

    fetchedData.add(Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false
    ));
    _articles = fetchedData;
    notifyListeners();
  }

  Future<void> deleteArticle(String id) async {
    List<Article> fetchedData = [];
        fetchedData.add(Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false,
    ));

    fetchedData.add(Article(
        article_id: "1",
        collection_id: "2",
        user_id: 1,
        title: "HEllo there",
        content: "bjhcbjhgfhgdfhvds",
        published: true,
        image_path:
            "https://images.pexels.com/photos/818252/pexels-photo-818252.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        views_count: 0,
        kudos_count: 0,
        date_created: DateTime.parse("1969-07-20 20:18:04Z"),
        date_updated: DateTime.parse("1969-07-20 20:18:04Z"),
        bookmarked: false
    ));
    _articles = fetchedData;
    notifyListeners();
  }
}
