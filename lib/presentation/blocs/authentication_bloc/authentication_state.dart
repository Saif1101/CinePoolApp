part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class UserAlreadyLoggedInState extends AuthenticationState{}

class AuthenticationSuccessRecordDoesntExist extends AuthenticationState {
  final AuthenticationDetail authenticationDetail;

  AuthenticationSuccessRecordDoesntExist(
      {@required this.authenticationDetail,
      });

  @override
  List<Object> get props => [AuthenticationDetail];

}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel currentUser;
  final String loginTime;

  AuthenticationSuccess({@required this.currentUser,this.loginTime});
  @override
  List<Object> get props => [currentUser,loginTime];
}



class UserDetailsUpdated extends AuthenticationState {
  final UserModel currentUser;

  UserDetailsUpdated({@required this.currentUser,});
  @override
  List<Object> get props => [currentUser.username,currentUser.genres];
}




class RegistrationInitial extends AuthenticationState {}

class RegistrationPageLoaded extends AuthenticationState{
  final Map<int, String> mapOfGenres;


  RegistrationPageLoaded({@required this.mapOfGenres});

}

class RegistrationFailed extends AuthenticationState {
  final String message;

  RegistrationFailed({this.message});

}

class RegistrationLoading extends AuthenticationState {}

class RegistrationComplete extends AuthenticationState{
  final UserModel currentUser;

  RegistrationComplete({@required this.currentUser});
}




