import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class AuthorsInput extends StatefulWidget {
  List<dynamic> authors;
  Function(List<dynamic>) setAuthors;
  AuthorsInput(this.authors, this.setAuthors);

  @override
  _AuthorsInputState createState() => _AuthorsInputState(authors, setAuthors);
}

class _AuthorsInputState extends State<AuthorsInput> {
  List<dynamic> authors;
  Function(List<dynamic>) setAuthors;

  _AuthorsInputState(this.authors, this.setAuthors);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (ChipsInput(
      initialValue: [...authors],
      decoration: InputDecoration(
        labelText: "Add author",
      ),
      maxChips: 4,
      onChanged: (data) {
        // print(data);
        setState(() {
          authors = [...data];
        });
        widget.setAuthors(data);
      },
      chipBuilder: (context, state, author) {
        return InputChip(
          label: Text(author),
          onDeleted: () => state.deleteChip(author),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      findSuggestions: (String author) {
        return [author];
      },
      suggestionBuilder: (context, state, author) {
        return ListTile(
            title: Text(author), onTap: () => {state.selectSuggestion(author)});
      },
    ));
  }
}
