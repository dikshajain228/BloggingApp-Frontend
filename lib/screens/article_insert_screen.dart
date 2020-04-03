import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

// widgets
import '../widgets/tags_input.dart';
import '../widgets/image_input.dart';

import '../providers/articles.dart';

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

  // NotusDocument _loadDocument() {
  //   final Delta delta = Delta()..insert("Zefyr Quick Start\n");
  //   return NotusDocument.fromDelta(delta);
  // }

  // void _saveDocument(BuildContext context) {
  //   final content = jsonEncode(_controller.document);
  //   String contentString = content.toString();
  //   final String title = _titleController.text;
  //   // print("Title " + title);
  //   // print(contentString);
  //   _showSaveDialog();
  // }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Post Article...",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                TagsInput(_tags, setTags),
                ImageInput(uploadedImage, setImage, image_url),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
              color: Colors.red,
              splashColor: Colors.redAccent,
            ),
            FlatButton(
              child: Text("Post"),
              color: Colors.teal,
              splashColor: Colors.tealAccent,
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
    print("Tags string: " + tags);
    final data = {
      "collectionId": widget.collection_id,
      "title": title,
      "content": content,
      "tags": tags,
    };
    Provider.of<Articles>(context).addArticle(data, uploadedImage).then((_) {
      print("Added article");
    });
  }
}
