import 'package:flutter/material.dart';
import 'package:sidenavi/widgets/collection_list.dart';


Widget collection_card(BuildContext context, String image, String title,String description,String owner, DateTime date) {
  //Post card
  return new Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(),
      child: makeListTile(context, image, title, description, owner,date),
    ),
  );
}