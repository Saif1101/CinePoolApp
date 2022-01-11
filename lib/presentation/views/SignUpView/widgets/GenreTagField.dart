import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

import '../../../widgets/tagsField.dart';


class GenreTagField extends StatelessWidget {
  final Map<int,String> genreMap;
//  final GlobalKey<TagsState> tagStateKey;
  List<String>genreNames=[];

  final GlobalKey<TagsState> tagStateKey;

   GenreTagField({this.genreMap, this.tagStateKey}){
     genreMap.values.forEach((element) {this.genreNames.add(element);});
   }


  @override
  Widget build(BuildContext context) {
    return genreTags(tagStateKey, this.genreNames);
  }
}

class GenreTags extends StatefulWidget {
  @override
  _GenreTagsState createState() => _GenreTagsState();
}

class _GenreTagsState extends State<GenreTags> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

