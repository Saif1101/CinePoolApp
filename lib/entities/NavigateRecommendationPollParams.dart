import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/presentation/blocs/ask_for_recommendations_post_list/ask_for_recommendations_post_list_bloc.dart';
import 'package:socialentertainmentclub/presentation/blocs/recommendations_poll_movie_list/recommendations_poll_list_bloc.dart';

class NavigateRecommendationsPollParams extends Equatable{
  final AskForRecommendationsPostListBloc askForRecommendationsPostListBloc;
  final RecommendationsPollListBloc recommendationsPollListBloc;
  final String blocName;

  NavigateRecommendationsPollParams({this.askForRecommendationsPostListBloc,
    this.recommendationsPollListBloc,
    @required this.blocName});

  @override
  List<Object> get props => [askForRecommendationsPostListBloc,recommendationsPollListBloc, blocName];

}