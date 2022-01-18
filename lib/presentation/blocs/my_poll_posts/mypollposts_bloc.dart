import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/PollPosts/get_myPollPosts.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/PollPostModel.dart';

part 'mypollposts_event.dart';
part 'mypollposts_state.dart';

class MyPollPostsBloc extends Bloc<MyPollPostsEvent, MyPollPostsState> {
  final GetMyPollPosts getMyPollPosts;


  MyPollPostsBloc({@required this.getMyPollPosts}) : super(MyPollPostsInitial()) {
      on<LoadMyPollPostsEvent>(_onLoadMyPollPostsEvent); 
  }

    Future<void> _onLoadMyPollPostsEvent(
      LoadMyPollPostsEvent event, 
      Emitter<MyPollPostsState> emit,
    ) async {
      emit(MyPollPostsLoading());
      final response = await getMyPollPosts(NoParams()); 
      emit(response.fold(
              (l) =>MyPollPostsError(
                errorMessage: l.errorMessage, 
                appErrorType: l.appErrorType
              ), 
              (r) => MyPollPostsLoaded(r)
            )
          );
    }


}
