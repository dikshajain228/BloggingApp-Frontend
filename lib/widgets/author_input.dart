import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class AuthorInput extends StatefulWidget {
  List<Map<String, dynamic>> authors;
  AuthorInput(this.authors);

  @override
  _AuthorInputState createState() => _AuthorInputState();
}

class _AuthorInputState extends State<AuthorInput> {
  List<int> _newAuthors = [];
  List<int> _deletedAuthors = [];
  List<Author> _initialAuthors = [];
  List<Author> _selectedAuthors = [];

  @override
  void initState() {
    super.initState();
    List<Author> _tempList = [];
    for (final data in widget.authors) {
      _tempList.add(Author(
        data["user_id"],
        data["username"],
        data["email"],
        data["image_url"],
      ));
    }
    setState(() {
      _initialAuthors = [..._tempList];
    });
  }

  @override
  Widget build(BuildContext context) {
    const mockResults = <Author>[
      Author(1, 'John Doe', 'jdoe@flutter.io',
          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      Author(2, 'Paul', 'paul@google.com',
          'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
      Author(3, 'Fred', 'fred@google.com',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(4, 'Brian', 'brian@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(5, 'John', 'john@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(6, 'Thomas', 'thomas@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(7, 'Nelly', 'nelly@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(8, 'Marie', 'marie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(9, 'Charlie', 'charlie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(10, 'Diana', 'diana@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(11, 'Ernie', 'ernie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(12, 'Gina', 'fred@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
    ];

    return Column(
      children: <Widget>[
        ChipsInput(
          initialValue: _initialAuthors,
          maxChips: 4,
          decoration: InputDecoration(
            labelText: "Add Author",
          ),
          findSuggestions: (String query) {
            if (query.length != 0) {
              return mockResults.where((profile) {
                return profile.username
                        .toLowerCase()
                        .contains(query.toLowerCase()) ||
                    profile.email.toLowerCase().contains(query.toLowerCase());
              }).toList();
            }
            return mockResults;
          },
          onChanged: (data) {
            print(data);
            setState(() {
              _selectedAuthors = [...data];
            });
          },
          chipBuilder: (context, state, profile) {
            return InputChip(
              key: ObjectKey(profile),
              label: Text(profile.username),
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(profile.image_url),
              ),
              onDeleted: () => state.deleteChip(profile),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
          suggestionBuilder: (context, state, profile) {
            return ListTile(
              key: ObjectKey(profile),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profile.image_url),
              ),
              title: Text(profile.username),
              subtitle: Text(profile.email),
              onTap: () => state.selectSuggestion(profile),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                List<Author> temp;
                // _newAuthors = _selectedAuthors - _initialAuthors
                temp = (_selectedAuthors.where(
                    (element) => !_initialAuthors.contains(element))).toList();
                for (var data in temp) {
                  _newAuthors.add(data.user_id);
                }
                temp = [];
                // _deletedAuthors = _initialAuthors - _selectedAuthors
                temp = (_initialAuthors.where(
                    (element) => !_selectedAuthors.contains(element))).toList();
                for (var data in temp) {
                  _deletedAuthors.add(data.user_id);
                }
                print("Selected authors: " + _selectedAuthors.toString());
                print("Deleted authors: " + _deletedAuthors.toString());
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      ],
    );
  }
}

class Author {
  final int user_id;
  final String username;
  final String email;
  final String image_url;

  const Author(this.user_id, this.username, this.email, this.image_url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Author &&
          runtimeType == other.runtimeType &&
          user_id == other.user_id;

  @override
  int get hashCode => username.hashCode;

  @override
  String toString() {
    return user_id.toString();
  }
}
