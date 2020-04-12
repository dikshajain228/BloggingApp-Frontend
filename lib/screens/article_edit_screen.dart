import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:zefyr/zefyr.dart';

import '../screens/article_screen.dart';

// widgets
import '../widgets/tags_input.dart';
import '../widgets/image_input.dart';

import '../providers/articles.dart';
import '../providers/article.dart';

class ArticleEditScreen extends StatefulWidget {
  static const routeName = "/article/edit";
  Article article;
  ArticleEditScreen(this.article);
  @override
  ArticleEditScreenState createState() => ArticleEditScreenState();
}

class ArticleEditScreenState extends State<ArticleEditScreen> {
  ZefyrController _controller;
  TextEditingController _titleController;
  FocusNode _focusNode;
  List<dynamic> _tags = [];

  File uploadedImage;

  @override
  void initState() {
    super.initState();
    _controller = ZefyrController(_loadContent());
    _focusNode = FocusNode();
    _titleController = TextEditingController();
    _titleController.text = widget.article.title;
    if (widget.article.tags == "") {
      setState(() {
        _tags = [];
      });
    } else {
      setState(() {
        _tags = widget.article.tags.split(",");
      });
    }
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

  NotusDocument _loadContent() {
    var data = jsonDecode(widget.article.content);
    print("data");
    print(data);
    print(NotusDocument.fromJson(data));
    return NotusDocument.fromJson(data);
  }

  void displayDialog(context, title, text) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(title: Text(title), content: Text(text)),
    );
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
        title: Text("Edit Article"),
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
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: Colors.white,
            onPressed: _showSaveDialog,
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: form,
      ),
    );
  }

  void _updateArticle() {
    if (uploadedImage != null) {
      print(uploadedImage.path);
    } else {
      print("no upload");
    }
    String title = _titleController.text;
    final content = jsonEncode((_controller.document));

    String tags = _tags.join(",");
    final data = {
      "article_id": widget.article.article_id,
      "title": title,
      "content": content,
      // edit
      "image_path":
          widget.article.image_path != "" ? widget.article.image_path : " ",
      "tags": tags,
    };

    Provider.of<Articles>(context)
        .updateArticle(data, uploadedImage)
        .then((articleId) {
      print(articleId);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Toast.show("Article updated!", context,
          duration: 7, gravity: Toast.BOTTOM);
    }).catchError((errorMessage) {
      print(errorMessage);
      displayDialog(
        context,
        "Error",
        errorMessage,
      );
    });
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
              'Update Article...',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                TagsInput(_tags, setTags),
                ImageInput(uploadedImage, setImage, widget.article.image_path),
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
              child: Text("Update"),
              textColor: Theme.of(context).colorScheme.primary,
              splashColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                _updateArticle();
              },
            ),
          ],
        );
      },
    );
  }
}
