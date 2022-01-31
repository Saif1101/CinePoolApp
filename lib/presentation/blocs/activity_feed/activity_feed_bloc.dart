import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/get_FeedItems.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';

part 'activity_feed_event.dart';
part 'activity_feed_state.dart';

class ActivityFeedBloc extends Bloc<ActivityFeedEvent, ActivityFeedState> {
  final GetFeedItems getFeedItems; 

  ActivityFeedBloc({@required this.getFeedItems}) : super(ActivityFeedInitial()) {
    on<LoadActivityFeedEvent>(_onLoadActivityFeedEvent);
  }

  Future<void> _onLoadActivityFeedEvent(
    LoadActivityFeedEvent event, 
    Emitter<ActivityFeedState> emit,
  ) async {
    emit(ActivityFeedLoading());
    final feedItems = await getFeedItems(NoParams());
    print("Loaded feed, no. of items fetched: $feedItems");
    emit (feedItems.fold(
      (l) => ActivityFeedError(errorMessage: l.errorMessage, appErrorType: l.appErrorType), 
      (r) => ActivityFeedLoaded(r)
      )
      );
  }


}
