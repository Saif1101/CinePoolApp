part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}




class AuthenticationStarted extends AuthenticationEvent {}

class CheckIfUserAlreadySignedInEvent extends AuthenticationEvent{}

class AuthenticationGoogleStarted extends AuthenticationEvent {}

class AuthenticationExited extends AuthenticationEvent {}



class LoadRegistrationPage extends AuthenticationEvent{}

class SignUpButtonPress extends AuthenticationEvent{
  final String timestamp;
  final String email;
  final String username;
  final String photoUrl;
  final String displayName;
  final String id;
  final BuildContext context;
  final GlobalKey<TagsState> tagStateKey;
  final Map<int, String> mapGenresWithID;

  SignUpButtonPress({
    @required this.timestamp,
    @required this.email,
    @required this.username,
    @required this.photoUrl,
    @required this.displayName,
    @required this.id,
    @required this.tagStateKey,
    @required this.context,
    @required this.mapGenresWithID});
}

class RegistrationCompleteEvent{}





class UserDetailsUpdateEvent extends AuthenticationEvent{
  final String username;
  final Map<String,String> selectedGenres;

  UserDetailsUpdateEvent(this.username, this.selectedGenres);

}

class UserUpdateCompleteEvent extends AuthenticationEvent{}





