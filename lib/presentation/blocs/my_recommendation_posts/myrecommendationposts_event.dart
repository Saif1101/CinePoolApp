part of 'myrecommendationposts_bloc.dart';

abstract class MyRecommendationPostsEvent extends Equatable {
  const MyRecommendationPostsEvent();

  @override
  List<Object> get props => [];
}

class LoadMyRecommendationPostsEvent extends MyRecommendationPostsEvent{}




