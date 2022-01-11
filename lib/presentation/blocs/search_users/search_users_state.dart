part of 'search_users_bloc.dart';




abstract class SearchUsersState extends Equatable {
  const SearchUsersState();
  @override

  List<Object> get props => [];
}

class SearchMoviesInitial extends SearchUsersState {
}
class SearchUsersLoaded extends SearchUsersState {
  final List<UserModel> users;

  SearchUsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class SearchUsersLoading extends SearchUsersState {
}
class SearchUsersError extends SearchUsersState {
}

class SearchUsersResultsCleared extends SearchUsersState{}