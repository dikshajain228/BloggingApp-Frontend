import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../widgets/drawer.dart';
import '../widgets/collection_list.dart';

class CollectionTestScreen extends StatefulWidget {
  static const routeName = "/tester";
  @override
  _CollectionTestScreenState createState() => _CollectionTestScreenState();
}

class _CollectionTestScreenState extends State<CollectionTestScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    print("Collection");
  }

  @override
  void didChangeDependencies() {
    Provider.of<Collections>(context).getCollections();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Collections tester"),
        ),
        body: CollectionList(),
        drawer: MainDrawer());
  }
}
