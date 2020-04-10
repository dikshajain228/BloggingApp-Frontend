import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../route_observer.dart' as route_observer;

import '../screens/collection_edit_screen.dart';
import '../screens/article_delete_screen.dart';
import '../screens/article_insert_screen.dart';
import '../screens/profile_screen.dart';

// Widgets
import '../widgets/collection_details_card.dart';
import '../widgets/articles_list.dart';
import '../widgets/author_input.dart';
import '../widgets/error_dialog.dart';

// Providers
import '../providers/collections.dart';
import '../providers/collection.dart';
import '../providers/articles.dart';

class CollectionScreen extends StatefulWidget {
  static const routeName = "/collection";
  String collectionId;
  CollectionScreen(this.collectionId);
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  Collection _collection;

  bool _isInit = true;
  bool _loadingCollection = true;
  bool _loadingArticles = true;
  bool _errorCollection = false;
  bool _errorArticles = false;
  List<dynamic> authors = [];
  List<dynamic> _authors = [];
  //should be deleted
  List<bool> inputs = new List<bool>();

  final routeObserver = route_observer.routeObserver;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    if (_isInit) {
      _loadData();
      setState(() {
        _isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    _loadData();
    super.didPopNext();
  }

  void _loadData() {
    // Get collection details
    Provider.of<Collections>(context)
        .fetchCollectionById(widget.collectionId)
        .then((data) {
      setState(() {
        _loadingCollection = false;
        _collection = data;
        _authors = data.authors;
      });
    }).catchError((errorMessage) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              errorMessage: errorMessage,
            );
          });
      setState(() {
        _errorCollection = true;
      });
    });

    // Get articles of this collection
    Provider.of<Articles>(context)
        .getCollectionArticles(widget.collectionId)
        .then((_) {
      setState(() {
        _loadingArticles = false;
      });
    }).catchError((errorMessage) {
      setState(() {
        _errorArticles = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Collection Screen"),
      ),
      body: (_errorCollection == true
          ? Text("An error occured")
          : (_loadingCollection == true
              ? SpinKitChasingDots(
                  color: Colors.teal,
                )
              : Column(
                  children: [
                    ChangeNotifierProvider.value(
                      value: _collection,
                      child: CollectionDetailsCard(),
                    ),
                    (_errorArticles == true
                        ? Text("An error occured")
                        : (_loadingArticles == true
                            ? SpinKitWanderingCubes(
                                color: Colors.teal,
                              )
                            : Flexible(
                                child: ArticlesList(),
                              ))),
                  ],
                ))),
      floatingActionButton: (_loadingCollection == true
          ? null
          : this._collection.is_owner
              ? plusFloatingButton()
              : this._collection.is_author
                  ? FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      onPressed: () {},
                      child: Icon(Icons.add),
                      tooltip: "Add Articles",
                    )
                  : null),
    );
  }

  void cancelChanges() {
    Navigator.of(context).pop();
    print("cancel");
  }

  void saveChanges() {
    //Call function to delete
    Navigator.of(context).pop();
    print("save");
  }

  void itemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

// Floating button for owners
  Widget plusFloatingButton() {
    return (SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(),
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => {},
      onClose: () => {},
      tooltip: 'Options',
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 10.0,
      children: [
        SpeedDialChild(
          child: Icon(Icons.delete_sweep),
          backgroundColor: Colors.tealAccent,
          label: 'Delete Collection',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showAlert(context),
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Colors.tealAccent,
          label: 'Edit Collection',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            {
              Navigator.of(context).pushNamed(
                EditCollection.routeName,
                arguments: _collection,
              );
            }
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.delete),
          backgroundColor: Colors.tealAccent,
          label: 'Delete Article',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleDeleteScreen.routeName);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.tealAccent,
          label: 'Add Article',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            Navigator.of(context).pushNamed(ArticleInsertScreen.routeName,
                arguments: _collection.collection_id);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.person),
          backgroundColor: Colors.tealAccent,
          label: 'Edit Authors',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: _showEditAuthorDialog,
        ),
        SpeedDialChild(
          child: Icon(Icons.person),
          backgroundColor: Colors.tealAccent,
          label: 'View Author',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: _showViewAuthorDialog,
        ),
      ],
    ));
  }

  _showEditAuthorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Authors...'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                AuthorInput(_authors, widget.collectionId),
              ],
            ),
          ),
        );
      },
    );
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Are You Sure Want To Delete?"),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                _collection
                    .deleteCollection(_collection.collection_id)
                    .then((_) {
                  print("Collection deleted");
                });
                //Delete the _collection
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                //Stay on the same page
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setAuthors(List<dynamic> authorsData) {
    setState(() {
      authors = [...authorsData];
    });
  }

  _showViewAuthorDialog() {
    //data = _getAuthorsofCollection
    final data = List<List<int>>.generate(
        5, (i) => List<int>.generate(2, (j) => i * 5 + j));
    print(data);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "View Authors",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Table(
                columnWidths: {
                  0: FixedColumnWidth(50.0),
                  1: FixedColumnWidth(250.0),
                },
                border: TableBorder.all(width: 1.0),
                children: data.map((item) {
                  return TableRow(
                      children: item.map((row) {
                    return Container(
                      color: Colors.white24,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          row.toString(),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  }).toList());
                }).toList(),
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
                color: Colors.red,
                splashColor: Colors.redAccent,
              ),
            ],
          );
        });
  }

  _showDeleteAuthorDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete Authors",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
                // child: Column(children: <Widget>[

                // DropdownButton<String>(
                //   value: dropdownValue,
                //   icon: Icon(Icons.arrow_drop_down),
                //   iconSize: 24,
                //   elevation: 16,

                ),
          );
        });
  }
}
