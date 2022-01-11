import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_Posts.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/Post.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final GetPosts getPosts;

  TimelineBloc({@required this.getPosts}) : super(TimelineInitial());

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
}



