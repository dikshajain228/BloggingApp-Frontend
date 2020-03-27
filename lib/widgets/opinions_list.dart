import '../widgets/opinion_preview_card.dart';

import '../providers/opinions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpinionSystem extends StatefulWidget {
  @override
  _OpinionSystemState createState() => _OpinionSystemState();
}

class _OpinionSystemState extends State<OpinionSystem> {
  @override
  Widget build(BuildContext context) {
    final opinionsData = Provider.of<Opinions>(context);
    final opinions = opinionsData.opinions;
    return Card(
      child: Column(
        children: <Widget>[
          Divider(),

          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Leave your opinion",
              suffixIcon: Icon(Icons.send, color: Colors.blue,)),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0,0),
              child: Text(opinions.length.toString()+ " Comments",),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: opinions.length,
            itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: opinions[index],
              child: OpinionPreviewCard(),
            ),
          )
        ],
      ),
    );
  }
}
