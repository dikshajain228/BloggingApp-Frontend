import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class TagsInput extends StatefulWidget {
  List<dynamic> tags;
  Function(List<dynamic>) setTags;
  TagsInput(this.tags, this.setTags);

  @override
  _TagsInputState createState() => _TagsInputState(tags, setTags);
}

class _TagsInputState extends State<TagsInput> {
  List<dynamic> tags;
  Function(List<dynamic>) setTags;

  _TagsInputState(this.tags, this.setTags);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (ChipsInput(
      initialValue: [...tags],
      decoration: InputDecoration(
        labelText: "Add tag",
      ),
      maxChips: 4,
      onChanged: (data) {
        // print(data);
        setState(() {
          tags = [...data];
        });
        widget.setTags(data);
      },
      chipBuilder: (context, state, tag) {
        return InputChip(
          label: Text(tag),
          onDeleted: () => state.deleteChip(tag),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      findSuggestions: (String tag) {
        if (tag.length == 0) {
          return <String>[];
        }
        return [tag];
      },
      suggestionBuilder: (context, state, tag) {
        return ListTile(
            title: Text(tag), onTap: () => {state.selectSuggestion(tag)});
      },
    ));
  }
}
