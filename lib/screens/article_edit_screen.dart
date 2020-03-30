import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class ArticleEditScreen extends StatefulWidget {
  static const routeName = "/article/edit";

  //for receiving the article from the article screen.
  final String value;
  ArticleEditScreen({Key key, this.value}) : super(key: key);

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
    // final content = jsonEncode(_controller.document);
    String contentString = _controller.document.toString();
    final String title = _titleController.text;
    print(contentString);
  }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Publish changes",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("Add tags"),
                ),
                ChipsInput(
                  initialValue: [...tags],
                  decoration: InputDecoration(
                    labelText: "Add tag",
                  ),
                  maxChips: 3,
                  onChanged: (data) {
                    // print(data);
                    setState(() {
                      tags = [...data];
                    });
                  },
                  chipBuilder: (context, state, tag) {
                    return InputChip(
                      label: Text(tag),
                      onDeleted: () => state.deleteChip(tag),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                  findSuggestions: (String tag) {
                    return [tag];
                  },
                  suggestionBuilder: (context, state, tag) {
                    return ListTile(
                        title: Text(tag),
                        onTap: () => {state.selectSuggestion(tag)});
                  },
                ),
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
