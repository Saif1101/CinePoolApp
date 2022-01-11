import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/AskForRecommendationsPostModel.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';

part 'ask_for_recommendations_post_event.dart';
part 'ask_for_recommendations_post_state.dart';

class AskForRecommendationsPostBloc extends Bloc<AskForRecommendationsPostEvent, AskForRecommendationsPostState> {

  final GetUserFromID getUserFromID;

  AskForRecommendationsPostBloc({@required this.getUserFromID}) : super(AskForRecommendationsPostInitial());

  @override
  Stream<AskForRecommendationsPostState> mapEventToState(AskForRecommendationsPostEvent event)
  async * {
    print("Inside AskForRecommendationsPostBloc: Incoming Event is $event");
    if(event is LoadAskForRecommendationsPostEvent){
      yield AskForRecommendationsPostLoading();
      final user = await getUserFromID(event.askForRecommendationsPost.ownerID);
      yield user.fold(
              (l) => AskForRecommendationsPostError(errorMessage: l.errorMessage,appErrorType: l.appErrorType),
              (r) => AskForRecommendationsPostLoaded(postOwner: r, askForRecommendationsPost: event.askForRecommendationsPost)
      );
    }
  }
}
