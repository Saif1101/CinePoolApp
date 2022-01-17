
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';




class genreTags extends StatefulWidget {
  GlobalKey<TagsState>_tagStateKey;
  List <String> _items;

  genreTags(this._tagStateKey,this._items);
  @override
  _genreTagsState createState() => _genreTagsState();
}

class _genreTagsState extends State<genreTags> {
//
  double _fontSize = 14;


  @override
  Widget build(BuildContext context) {
    return Tags(
      key: widget._tagStateKey,
      itemCount: widget._items.length, // required
      itemBuilder: (int index){
        final item = widget._items[index];
        return ItemTags(
          activeColor: Color(0xFF2693F4),
          active: false,
          // Each ItemTags must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(index.toString()),
          index: index, // required
          title: item,
          textStyle: TextStyle(fontSize: _fontSize,fontWeight: FontWeight.bold ),
          combine: ItemTagsCombine.withTextBefore,
          icon: ItemTagsIcon(
            icon: Icons.add,
          ), // OR null,// OR null,
          onPressed: (item) =>item.active==!item.active,
          onLongPressed: (item) => print(item),
        );

      },
    );
  }
}



