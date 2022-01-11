part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];

}

class EditProfileInitial extends EditProfileState {}

class EditProfilePageLoaded extends EditProfileState{
  final String username;
  final Map<int,String> genres;

  EditProfilePageLoaded(this.username, this.genres);
}

class EditProfileSuccess extends EditProfileState{
  final String username;
  final Map<String, String> selectedGenres;

  EditProfileSuccess(this.username, this.selectedGenres);
}



class EditProfileError extends EditProfileState{
  final String errorMessage;
  final AppErrorType errorType;


  EditProfileError(this. errorMessage, this.errorType);
}

class EditProfilePageLoading extends EditProfileState{}
