import 'package:bloggingapp/screens/article_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:io';
import 'dart:convert';

// widgets
import '../widgets/tags_input.dart';
import '../widgets/image_input.dart';

import '../providers/articles.dart';
import '../providers/article.dart';

class ArticleEditScreen extends StatefulWidget {
  static const routeName = "/article/edit";
  @override
  ArticleEditScreenState createState() => ArticleEditScreenState();
}

class ArticleEditScreenState extends State<ArticleEditScreen> {
  ZefyrController _controller;
  TextEditingController _titleController;
  FocusNode _focusNode;
  List<dynamic> tags = ["haha", "tag1", "tag2"];
  String content = "Article content\n";
  String title = "Article Title\n";

  Article article;

  File uploadedImage;
  String image_url = "https://picsum.photos/200";

  @override
  void initState() {
    super.initState();

    final Delta delta = Delta()..insert(content);
    final document = NotusDocument.fromDelta(delta);
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
    _titleController = TextEditingController();
    _titleController.text = title;
  }

  void setImage(File image) {
    setState(() {
      uploadedImage = image;
    });
  }

  void setTags(List<dynamic> tagsData) {
    setState(() {
      tags = [...tagsData];
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
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.pop(context, "1"); // Change to article id
          },
        ),
        title: Text("Edit Article"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            onPressed: () => _saveDocument(context),
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: form,
      ),
    );
  }

  void _saveDocument(BuildContext context) {
    // final content = jsonEncode(_controller.document);
    String contentString = _controller.document.toString();
    final String title = _titleController.text;
    _showSaveDialog();
  }

  void _submitArticle() {
    final content = jsonEncode(_controller.document);
    String contentString = content.toString();
    final String title = _titleController.text;
    print(contentString);
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
  }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Publish changes...",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                TagsInput(tags, setTags),
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
                _submitArticle();
                print("tags");
                print(tags);
              },
            ),
          ],
        );
      },
    );
  }
}
