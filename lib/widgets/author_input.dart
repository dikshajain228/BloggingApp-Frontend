import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

import '../models/author.dart';
// import '../widgets/chips_input.dart';

class AuthorInput extends StatefulWidget {
  List<dynamic> authors;
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
      _selectedAuthors = [..._tempList];
    });
  }

  @override
  Widget build(BuildContext context) {
    var mockResults = <Author>[
      Author(100, 'John Doe', 'jdoe@flutter.io',
          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      Author(102, 'Paul', 'paul@google.com',
          'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
      Author(101, 'Fred', 'fred@google.com',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(103, 'Brian', 'brian@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(104, 'John', 'john@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(105, 'Thomas', 'thomas@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(111, 'Nelly', 'nelly@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(112, 'Marie', 'marie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(1221, 'Charlie', 'charlie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(121, 'Diana', 'diana@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(132, 'Ernie', 'ernie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      Author(133, 'Gina', 'fred@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
    ];

    return Column(
      children: <Widget>[
        ChipsInput(
          initialValue: _initialAuthors,
          enabled: true,
          maxChips: 4,
          textStyle: TextStyle(height: 1.5, fontFamily: "Roboto", fontSize: 16),
          decoration: InputDecoration(
            labelText: "Select People",
          ),
          findSuggestions: (String query) async {
            if (query.length != 0) {
              final fetchedAuthors = await Author.getSuggestions(query);
              print("fetched suggestions");
              print(fetchedAuthors);
              return fetchedAuthors;
            }
            return <Author>[];
          },
          onChanged: (data) {
            print("On changed");
            print(data);
            setState(() {
              _selectedAuthors = [...data];
            });
          },
          chipBuilder: (context, state, profile) {
            return InputChip(
              key: ObjectKey(profile),
              label: Text(profile.username),
              avatar: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: (profile.image_url != null
                      ? profile.image_url
                      : "http://via.placeholder.com/640x360"),
                  placeholder: (context, url) => Image.network(
                    "http://via.placeholder.com/640x360",
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 50.0,
                  width: 50.0,
                ),
              ),
              onDeleted: () => state.deleteChip(profile),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
          suggestionBuilder: (context, state, profile) {
            return ListTile(
              key: ObjectKey(profile),
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: (profile.image_url != null
                      ? profile.image_url
                      : "http://via.placeholder.com/640x360"),
                  placeholder: (context, url) => Image.network(
                    "http://via.placeholder.com/640x360",
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 50.0,
                  width: 50.0,
                ),
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
                print("selected");
                print(_selectedAuthors);
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
                print("New authors: " + _newAuthors.toString());
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
