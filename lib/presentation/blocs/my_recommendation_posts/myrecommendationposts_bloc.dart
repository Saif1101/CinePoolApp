import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/RecommendationPosts/get_myRecommendationPosts.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';

part 'myrecommendationposts_event.dart';
part 'myrecommendationposts_state.dart';

class MyRecommendationPostsBloc extends Bloc<MyRecommendationPostsEvent, MyRecommendationPostsState> {
  final GetMyRecommendationPosts getMyRecommendationPosts; 


  MyRecommendationPostsBloc({
    @required this.getMyRecommendationPosts
  }) : super(MyRecommendationPostsInitial()) {
     on<LoadMyRecommendationPostsEvent>(_onLoadMyRecommendationPostsEvent); 
  }

  Future<void> _onLoadMyRecommendationPostsEvent(
    LoadMyRecommendationPostsEvent event, 
    Emitter<MyRecommendationPostsState> emit,
  ) async {
    emit( MyRecommendationPostsLoading());
      final response = await getMyRecommendationPosts(NoParams()); 
      emit(response.fold(
              (l) =>MyRecommendationPostsError(
                errorMessage: l.errorMessage, 
                appErrorType: l.appErrorType
              ), 
              (r) => MyRecommendationPostsLoaded(r)
            )
          );
  }
}
