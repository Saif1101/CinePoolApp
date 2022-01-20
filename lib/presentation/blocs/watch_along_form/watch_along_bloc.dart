import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/create_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/delete_WatchAlong.dart';

import 'package:socialentertainmentclub/entities/DeleteWatchAlongParams.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';


part 'watch_along_event.dart';
part 'watch_along_state.dart';

class WatchAlongFormBloc extends Bloc<WatchAlongEvent, WatchAlongState> {
  final CheckWatchAlong checkWatchAlong;
  final CreateWatchAlong createWatchAlong;
  final DeleteWatchAlong deleteWatchAlong;

  WatchAlongFormBloc({@required this.checkWatchAlong,
   @required this.createWatchAlong,
    @required this.deleteWatchAlong}) : super(WatchAlongInitial()){
      on<ToggleScheduleWatchAlongEvent>(_onToggleScheduleWatchAlongEvent);
      on<CheckIfScheduledEvent>(_onCheckIfScheduledEvent);
      on<WatchAlongDateEditEvent>(_onWatchAlongDateEditEvent);
      on<WatchAlongSubmitEvent>(_onWatchAlongSubmitEvent);
    }

Future<void> _onToggleScheduleWatchAlongEvent(
ToggleScheduleWatchAlongEvent event, 
Emitter<WatchAlongState> emit,
) async {
   if(event.watchAlongID!='NA'){
        emit (WatchAlongLoading());
        await deleteWatchAlong(DeleteWatchAlongParams(watchAlongID: event.watchAlongID, movieID: event.movieID));
        emit(IsScheduled('NA'));
      }else{
        emit(CreateWatchAlongState(event.movieID,DateTime.now()));
      }
}

Future<void> _onCheckIfScheduledEvent(
  CheckIfScheduledEvent event, 
  Emitter<WatchAlongState> emit,
) async {
  final response = await checkWatchAlong(event.movieID.toString());
      if(response.isRight())
      emit(response.fold(
              (l) =>  WatchAlongError(),
              (r) => IsScheduled(r)
      ));
}

void _onWatchAlongDateEditEvent(
  WatchAlongDateEditEvent event,
  Emitter<WatchAlongState> emit,
){
  emit( CreateWatchAlongState(event.movieID,event.dateTime));
}

Future<void> _onWatchAlongSubmitEvent(
  WatchAlongSubmitEvent event, 
  Emitter<WatchAlongState> emit,
) async {
  final WatchAlong watchAlong = WatchAlong(
          title: event.title,
          ownerID: FirestoreConstants.currentUserId,
          movieID: event.movieID,
          scheduledTime: event.scheduledTime, location: event.location);

      await createWatchAlong(watchAlong);

      final response = await checkWatchAlong(event.movieID);
      emit(response.fold(
              (l) =>  WatchAlongError(),
              (r) => IsScheduled(r)
      ));
}

/* LEGACY mapEventToState
  @override
  Stream<WatchAlongState> mapEventToState(WatchAlongEvent event)
  async * {
    if(event is ToggleScheduleWatchAlongEvent){
      if(event.isScheduled){
        yield WatchAlongLoading();
        await removeWatchAlong(event.movieID);
        yield IsScheduled(false);
      }else{
        yield CreateWatchAlongState(event.movieID,DateTime.now());
      }
    }
    else if (event is CheckIfScheduledEvent){
      final response = await checkWatchAlong(event.movieID.toString());
      if(response.isRight())
      yield response.fold(
              (l) =>  WatchAlongError(),
              (r) => IsScheduled(r)
      );
    }
    else if (event is WatchAlongDateEditEvent){
      yield CreateWatchAlongState(event.movieID,event.dateTime);
    }
    else if(event is WatchAlongSubmitEvent){
      final WatchAlong watchAlong = WatchAlong(
          title: event.title,
          ownerID: FirestoreConstants.currentUserId,
          movieID: event.movieID,
          scheduledTime: event.scheduledTime, location: event.location);

      await createWatchAlong(watchAlong);

      final response = await checkWatchAlong(event.movieID);
      yield response.fold(
              (l) =>  WatchAlongError(),
              (r) => IsScheduled(r)
      );
    }
  }
  */
}
