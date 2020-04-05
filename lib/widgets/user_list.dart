import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';
import '../widgets/user_preview_card.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Users>(context).users;

    return users.length == 0
        ? Center(
            child: Container(
              child: Text("No users found"),
            ),
          )
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: users[index],
              child: UserPreviewCard(),
            ),
          );
  }
}
