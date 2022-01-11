import 'package:equatable/equatable.dart';


class UserSignUpParams extends Equatable{
  final String id;
  final String username;
  final String photoUrl;
  final String email;
  final Map<String, String> selectedGenres;
  final String timestamp;
  final String displayName;

  UserSignUpParams({ this.id,
       this.username,
       this.photoUrl,
       this.email,
       this.selectedGenres,
       this.timestamp,
      this.displayName});

  @override

  List<Object> get props => [id, username, photoUrl, email, photoUrl, email, selectedGenres, timestamp, displayName];
}
