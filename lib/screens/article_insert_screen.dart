import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'package:image_picker/image_picker.dart';

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

  // Image input
  Future<File> file;
  String status = '';
  String base64Image;
  File uploadedFile;
  String uploadError = 'Error Uploading Image';

  @override
  void initState() {
    super.initState();
    // Initial content of text editor
    final Delta delta = Delta()..insert("Enter content\n");
    final document = NotusDocument.fromDelta(delta);
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
    _titleController = TextEditingController();
  }

  void chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    print("Choose image");
    print(file.toString());
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
    print(contentString);
    print(uploadedFile.path);
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
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                OutlineButton(
                  onPressed: chooseImage,
                  child: Text('Choose Image'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                showImage(),
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

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          uploadedFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
