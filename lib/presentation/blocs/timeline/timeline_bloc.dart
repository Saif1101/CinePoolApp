import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_Posts.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_RecentUsers.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/Post.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final GetPosts getPosts;
  final GetRecentUsers getRecentUsers;

  TimelineBloc({@required this.getPosts, @required this.getRecentUsers}) : super(TimelineInitial()){
    on<LoadTimelineEvent>(_onLoadTimelineEvent);
  }

  Future<void> _onLoadTimelineEvent(
    LoadTimelineEvent event, 
    Emitter<TimelineState> emit, 
  ) async {
      emit(TimelineLoading());
      final response = await getPosts(NoParams());
      if(response.isRight()){
        List<Post> posts = response.getOrElse(null);
        if(posts.length==0){
          final recentUsersEither = await getRecentUsers(NoParams()); 
          emit(recentUsersEither.fold(
            (l) =>  TimelineError(appErrorType: l.appErrorType, errorMessage: l.errorMessage), 
            (r) =>  TimelinePostsEmpty(r))
            );
        } else{
          emit(TimelineLoaded(posts: posts));
        }
      } else{
        emit(TimelineError(appErrorType: AppErrorType.database, errorMessage: "Error Fetching Posts."));
      }
  }

  /*LEGACY mapEventToState

  @override
  Stream<TimelineState> mapEventToState(TimelineEvent event) async* {
    if(event is LoadTimelineEvent){
      yield TimelineLoading();
      final response = await getPosts(NoParams());
      yield response.fold(
              (l) => TimelineError(appErrorType: l.appErrorType, errorMessage: l.errorMessage),
              (r) => TimelineLoaded(posts: r)
      );
    }
  }
  */
}



