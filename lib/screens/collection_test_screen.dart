import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/collections.dart';
import '../widgets/drawer.dart';

class CollectionTestScreen extends StatefulWidget {
  static const routeName = "/tester";
  @override
  _CollectionTestScreenState createState() => _CollectionTestScreenState();
}

class _CollectionTestScreenState extends State<CollectionTestScreen> {
  @override
  void initState() {
    super.initState();
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
        body: Text("Hello"),
        drawer: MainDrawer());
  }
}
