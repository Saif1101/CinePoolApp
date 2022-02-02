import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/ActivityFeed/DeleteActivityFromFeed.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_pollPost.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_recommendationPost.dart';
import 'package:socialentertainmentclub/domain/usecases/posts/get_watchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/entities/DeleteActivityFromFeedParams.dart';
import 'package:socialentertainmentclub/entities/FeedActivityItem.dart';
import 'package:socialentertainmentclub/entities/FetchRecommendationPollPostParams.dart';
import 'package:socialentertainmentclub/entities/FetchWatchAlongParams.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/Post.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

part 'post_from_feed_event.dart';
part 'post_from_feed_state.dart';

class PostFromFeedBloc extends Bloc<PostFromFeedEvent, PostFromFeedState> {
  final GetRecommendationPost getRecommendationPost;
  final GetPollPost getPollPost;
  final GetWatchAlong getWatchAlong;
  final DeleteActivityFromFeed deleteActivityFromFeed;
  final GetUserFromID getUserFromID;

  PostFromFeedBloc(
      {@required this.getUserFromID,
      @required this.deleteActivityFromFeed,
      @required this.getRecommendationPost,
      @required this.getPollPost,
      @required this.getWatchAlong})
      : super(PostFromFeedInitial()) {
    on<LoadPostEvent>(_onLoadPostEvent);
    on<DeleteActivityForPostEvent>(_onDeleteActivityForPostEvent);
    on<LoadFollowerProfileEvent>(_onLoadFollowerProfileEvent);
  }

  Future<void> _onLoadFollowerProfileEvent(
    LoadFollowerProfileEvent event,
    Emitter<PostFromFeedState> emit,
  ) async {
    emit(PostFromFeedLoading());

    final user = await getUserFromID(event.newFollowerActivity.actorUserID);

    emit(user.fold(
        (l) => PostFromFeedError(
            errorMessage: l.errorMessage, appErrorType: l.appErrorType),
        (r) => FollowerProfileLoadedState(r)));
  }

  Future<void> _onLoadPostEvent(
    LoadPostEvent event,
    Emitter<PostFromFeedState> emit,
  ) async {
    emit(PostFromFeedLoading());
    //will return PollPostModel, WatchAlong, AskForRecommendationPostModel, pass these to the respective widgets
    if (event.feedActivityItem != null) {
      if (event.feedActivityItem.type == 'VoteAdded') {
        print(
            'Fetch path : ${event.feedActivityItem.postOwnerID}, ${event.feedActivityItem.postID}');
        final response = await getPollPost(FetchRecommendationPollPostParams(
            ownerID: event.feedActivityItem.postOwnerID,
            postID: event.feedActivityItem.postID));
        emit(response.fold(
            (l) => PostFromFeedError(
                errorMessage: l.errorMessage, appErrorType: l.appErrorType),
            (r) => PostFromFeedLoaded(r)));
      } else if (event.feedActivityItem.type == 'RecommendationAdded') {
        print(
            'Fetch path : ${event.feedActivityItem.postOwnerID}, ${event.feedActivityItem.postID}');
        final response = await getRecommendationPost(
            FetchRecommendationPollPostParams(
                ownerID: event.feedActivityItem.postOwnerID,
                postID: event.feedActivityItem.postID));
        emit(response.fold(
            (l) => PostFromFeedError(
                errorMessage: l.errorMessage, appErrorType: l.appErrorType),
            (r) => PostFromFeedLoaded(r)));
      } else if (event.feedActivityItem.type == 'OptedInToWatchAlong') {
        final response = await getWatchAlong(FetchWatchAlongParams(
            ownerID: event.feedActivityItem.postOwnerID,
            movieID: event.feedActivityItem.movieID));
        emit(response.fold(
            (l) => PostFromFeedError(
                errorMessage: l.errorMessage, appErrorType: l.appErrorType),
            (r) => PostFromFeedLoaded(r)));
      } else {
        print("Invalid Type");
        emit(PostFromFeedError(errorMessage: "Invalid Type"));
      }
    } else {
      emit(PostDoesNotExist());
    }
  }

  void _onDeleteActivityForPostEvent(
    DeleteActivityForPostEvent event,
    Emitter<PostFromFeedState> emit,
  ) async {
    await deleteActivityFromFeed(DeleteActivityFromFeedParams(
      feedOwnerID: FirestoreConstants.currentUserId,
      activityID: event.activityID,
    ));
  }
}
