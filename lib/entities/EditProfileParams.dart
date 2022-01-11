import 'package:equatable/equatable.dart';

class EditProfileParams extends Equatable{
  final String username;
  final Map<String,String> genres;

  EditProfileParams(this.username, this.genres);

  @override

  List<Object> get props => [username,genres];

}