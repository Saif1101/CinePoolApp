import 'Genre.dart';

// GenreList class object will yield a list of Genre objects. Genres and their id can then be accessed by
// traversing this list of objects and accessing the attributes of the Genre object

class GenreList {
  List<Genre> genres;


  GenreList.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

