
import 'package:bloggingapp/screens/article_insert_screen.dart';
import 'package:bloggingapp/widgets/authors_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bloggingapp/screens/collection_edit_screen.dart';
import 'article_delete_screen.dart';

// Widgets
import '../widgets/collection_details_card.dart';
import '../widgets/articles_list.dart';

// Providers
import '../providers/articles.dart';
import '../providers/collections.dart';
import '../providers/collection.dart';

class CollectionScreen extends StatefulWidget {
  static const routeName = "/collection";

  var collection_id;

  CollectionScreen(this.collection_id);

  @override
  _CollectionScreenState createState() => _CollectionScreenState(collection_id);
}

class _CollectionScreenState extends State<CollectionScreen>
    with SingleTickerProviderStateMixin {
  var collection_id;
  Collection collection;
  List<dynamic> authors = [];
  //should be deleted
  List<bool> inputs = new List<bool>();
  //to be removed
//  String dropdownValue = 'One';
//   List <String> spinnerItems = [
//     'One', 
//     'Two', 
//     'Three', 
//     'Four', 
//     'Five'
//     ] ;


  _CollectionScreenState(this.collection_id);

  @override
  void initState() {
    super.initState();
    print("Collection screen");
    print(this.collection_id);
  }

  @override
  void didChangeDependencies() {
    collection = Provider.of<Collections>(context).findById(collection_id);
    Provider.of<Articles>(context).getCollectionArticles(collection_id);
    super.didChangeDependencies();
    print(collection.collection_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collection Screen"),
      ),
      body: Column(
        children: [
          ChangeNotifierProvider.value(
            value: collection,
            child: CollectionDetailsCard(),
          ),
          Flexible(child: ArticlesList()),
        ],
      ),
      floatingActionButton: this.collection.is_owner
          ? plusFloatingButton()
          : this.collection.is_author
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                  child: Icon(Icons.add),
                  tooltip: "Add Articles",
                )
              : null,
    );
  }

  void cancelChanges(){
    Navigator.of(context).pop();
    print("cancel");
  }

void saveChanges(){
    //Call function to delete
    Navigator.of(context).pop();
    print("save");
  }

void ItemChange(bool val,int index){
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
          onTap: () => 
            showAlert(context),
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Colors.tealAccent,
          label: 'Edit Collection',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: (){
            {
              Navigator.of(context).pushNamed(
              EditCollection.routeName,
              arguments: collection.collection_id,
            );
            }
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.delete),
          backgroundColor: Colors.tealAccent,
          label: 'Delete Article',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => 
            {Navigator.of(context).pushNamed(ArticleDeleteScreen.routeName)},
        ),
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.tealAccent,
          label: 'Add Article',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => {Navigator.of(context).pushNamed(ArticleInsertScreen.routeName)},
        ),
        SpeedDialChild(
            child: Icon(Icons.person_add),
            backgroundColor: Colors.tealAccent,
            label: 'Add Author',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: _showAddAuthorDialog
        ),
        SpeedDialChild(
            child: Icon(Icons.delete_forever),
            backgroundColor: Colors.tealAccent,
            label: 'Delete Author',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: _showDeleteAuthorDialog
        ),
        SpeedDialChild(
            child: Icon(Icons.person),
            backgroundColor: Colors.tealAccent,
            label: 'View Author',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: _showViewAuthorDialog
        ),
      ],
    ));
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
                //Delete the collection
                Navigator.of(context).pop();
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

  _showAddAuthorDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add Authors",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                AuthorsInput(authors, setAuthors),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                print("hey");
                Navigator.of(context).pop();
              },
              child: Text("Close"),
              color: Colors.red,
              splashColor: Colors.redAccent,
            ),
            FlatButton(
              child: Text("Add"),
              color: Colors.teal,
              splashColor: Colors.tealAccent,
              onPressed: () {
                print("authors");
                print(authors);
              },
            ),
          ],
        );
      },
    );
  }

  _getAuthorsofCollection(){
    // get authors from backend
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
          child: 
            Table(
               columnWidths: {
               0: FixedColumnWidth(50.0),
               1: FixedColumnWidth(250.0),
               },
              border: TableBorder.all(width: 1.0),
              children: data.map((item) {
                return TableRow(
                children: item.map((row) {
                  return Container(
                    color : Colors.white24,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        row.toString(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                }).toList()
              );
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
    }
  );
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
          //   style: TextStyle(color: Colors.red, fontSize: 18),
          //   underline: Container(
          //     height: 2,
          //     color: Colors.deepPurpleAccent,
          //   ),
          //   onChanged: (String data) {
          //     setState(() {
          //       dropdownValue = data;
          //     });
          //   },
          //   items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          // ),
          
          // Text('Selected Item = ' + '$dropdownValue', 
          // style: TextStyle
          //     (fontSize: 22, 
          //     color: Colors.black)),
          // ]
          ),
        );
      }
    );
}   

// ListView makeCheckList(){
//   return ListView.builder(
//           itemCount: inputs.length,
//           itemBuilder: (BuildContext context, int index){
//             return new Card(
//               child: new Container(
//                 padding: new EdgeInsets.all(10.0),
//                 child: new Column(
//                   children: <Widget>[
//                     new CheckboxListTile(
//                         value: inputs[index],
//                         title: new Text('item $index'),
//                         controlAffinity: ListTileControlAffinity.leading,
//                         onChanged:(bool val){ItemChange(val, index);}
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }
//       );
// }
}
