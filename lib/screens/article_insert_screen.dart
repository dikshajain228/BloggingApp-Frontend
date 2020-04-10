import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:toast/toast.dart';

// widgets
import '../widgets/tags_input.dart';
import '../widgets/image_input.dart';

import '../providers/articles.dart';
import '../screens/article_screen.dart';

class ArticleInsertScreen extends StatefulWidget {
  static const routeName = "/article/insert";
  String collection_id;
  ArticleInsertScreen(this.collection_id);
  @override
  ArticleInsertScreenState createState() => ArticleInsertScreenState();
}

class ArticleInsertScreenState extends State<ArticleInsertScreen> {
  ZefyrController _controller;
  TextEditingController _titleController;
  FocusNode _focusNode;
  List<dynamic> _tags = [];

  File uploadedImage;
  String image_url = "https://picsum.photos/200";

  @override
  void initState() {
    super.initState();
    // Initial content of text editor
    final Delta delta = Delta()..insert("Start typing...\n");
    final document = NotusDocument.fromDelta(delta);
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
    _titleController = TextEditingController();
  }

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }

  void setTags(List<dynamic> tagsData) {
    setState(() {
      _tags = [...tagsData];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double editorHeight = screenHeight * 0.65;

    // text editor
    final editor = ZefyrField(
      height: editorHeight,
      controller: _controller,
      focusNode: _focusNode,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      physics: ClampingScrollPhysics(),
    );

    // Title field
    final titleField = TextField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: 'Enter Article Title...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );

    // Input form
    final form = Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            titleField,
            SizedBox(
              height: 10,
            ),
            editor
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff191654),
                  Color(0xff43c6ac),
                  Color(0xff6dffe1),
                ]),
          ),
        ),
        title: Text("New Article"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            tooltip: "Post article",
            onPressed: _showSaveDialog,
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: form,
      ),
    );
  }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          titlePadding: EdgeInsets.all(0),
          title: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              'Post Article...',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                TagsInput(_tags, setTags),
                SizedBox(
                  height: 10,
                ),
                ImageInput(uploadedImage, setImage, image_url),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              textColor: Theme.of(context).colorScheme.error,
              splashColor: Theme.of(context).colorScheme.error,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Post"),
              textColor: Theme.of(context).colorScheme.primary,
              splashColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                _insertArticle();
              },
            ),
          ],
        );
      },
    );
  }

  void _insertArticle() {
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
    String title = _titleController.text;
    final content = jsonEncode((_controller.document).toJson());
    String tags = _tags.join(",");
    final data = {
      "collectionId": widget.collection_id,
      "title": title,
      "content": content,
      "tags": tags,
    };
    Provider.of<Articles>(context)
        .addArticle(data, uploadedImage)
        .then((message) {
      print(message);
      // Navigator.of(context).pushReplacementNamed(ArticleScreen.routeName);
      // pass article id?
      Toast.show("New article added!", context,
          duration: 7, gravity: Toast.BOTTOM);
    }).catchError((errorMessage) {
      print(errorMessage);
      Navigator.of(context).pushReplacementNamed(ArticleInsertScreen.routeName);
      Toast.show(errorMessage, context, duration: 7, gravity: Toast.BOTTOM);
    });
  }
}
