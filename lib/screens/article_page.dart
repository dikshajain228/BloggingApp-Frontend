import 'package:flutter/material.dart';
import 'package:bloggingapp/widgets/header.dart';
class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: header("Articles"),
      ),
      body: Center(
        child: Text('Page still under construction'),
      ),
    );
  }
}
