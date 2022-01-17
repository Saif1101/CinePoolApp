import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/get_MyWatchAlongs.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

part 'my_watch_alongs_event.dart';
part 'my_watch_alongs_state.dart';

class MyWatchAlongsBloc extends Bloc<MyWatchAlongsEvent, MyWatchAlongsState> {
  final GetMyWatchAlongs getMyWatchAlongs;

  MyWatchAlongsBloc({@required this.getMyWatchAlongs}) : super(MyWatchAlongsInitial()){
    on<LoadMyWatchAlongsEvent>(_onLoadMyWatchAlongsEvent);
  }

  Future<void> _onLoadMyWatchAlongsEvent(
    LoadMyWatchAlongsEvent event, 
    Emitter<MyWatchAlongsState> emit,
  ) async {
    emit( MyWatchAlongsLoading());
      final response = await getMyWatchAlongs(NoParams()); 
      emit(response.fold(
              (l) =>MyWatchAlongsError(
                errorMessage: l.errorMessage, 
                appErrorType: l.appErrorType
              ), 
              (r) => MyWatchAlongsLoaded(r)
          ));
  }

  /* LEGACY mapEventsToState 

  @override
  Stream<MyWatchAlongsState> mapEventToState(MyWatchAlongsEvent event)
  async* {
    if(event is LoadMyWatchAlongsEvent){
      yield MyWatchAlongsLoading();
      final response = await getMyWatchAlongs(NoParams()); 
      yield response.fold(
              (l) =>MyWatchAlongsError(
                errorMessage: l.errorMessage, 
                appErrorType: l.appErrorType
              ), 
              (r) => MyWatchAlongsLoaded(r));
    }
  }
  */
}
