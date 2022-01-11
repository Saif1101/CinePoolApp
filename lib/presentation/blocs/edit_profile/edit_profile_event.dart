part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadEditPageEvent extends EditProfileEvent{
  final String username;

  LoadEditPageEvent({this.username});

}


class EditButtonPress extends EditProfileEvent{
  final String username;
  final GlobalKey<TagsState> tagStateKey;
  final Map<int,String> mapGenresWithID;
  final BuildContext context;

  EditButtonPress({@required this.context,@required this.mapGenresWithID,
  @required this.username,
    @required this.tagStateKey,});
}

