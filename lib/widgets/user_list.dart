import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users.dart';
import '../widgets/user_preview_card.dart';

class CollectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<Users>(context);
    final users = usersData.users;

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: users[index],
        child: UserPreviewCard(),
      ),
    );
  }
}