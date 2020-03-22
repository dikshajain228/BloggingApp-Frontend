import 'package:bloggingapp/widgets/header.dart';
import 'package:flutter/material.dart';

class BookmarkArticles extends StatefulWidget{
  @override
  BookmarkArticlesState createState() => BookmarkArticlesState();
}

class BookmarkArticlesState extends State<BookmarkArticles>
{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: header("Bookmarked Articles"),
      body : ListView.builder(

      )
    );
  }
}