import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class ArticleInsertScreen extends StatefulWidget {
  static const routeName = "/article/insert";
  @override
  ArticleInsertScreenState createState() => ArticleInsertScreenState();
}

class ArticleInsertScreenState extends State<ArticleInsertScreen> {
  ZefyrController _controller;
  TextEditingController _titleController;
  FocusNode _focusNode;
  List<String> tags;

  @override
  void initState() {
    super.initState();
    // Initial content of texr editor
    final Delta delta = Delta()..insert("Enter content\n");
    final document = NotusDocument.fromDelta(delta);
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double editorHeight = screenHeight * 0.65;

    // text editor
    final editor = ZefyrField(
      height: editorHeight, // set the editor's height
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
        title: Text("Editor page"),
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

  // NotusDocument _loadDocument() {
  //   final Delta delta = Delta()..insert("Zefyr Quick Start\n");
  //   return NotusDocument.fromDelta(delta);
  // }

  void _saveDocument(BuildContext context) {
    final content = jsonEncode(_controller.document);
    String contentString = content.toString();
    final String title = _titleController.text;
    // print("Title " + title);
    // print(contentString);
    _showSaveDialog();
  }

  void _submitArticle() {
    final content = jsonEncode(_controller.document);
    String contentString = content.toString();
    final String title = _titleController.text;
    // print("Title " + title);
    // print(contentString);
    // print("lala");
  }

  // Save alert dialog
  void _showSaveDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Post Article",
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
