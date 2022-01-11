import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data/core/Firestore_constants.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/create_WatchAlong.dart';

import 'package:socialentertainmentclub/domain/usecases/watchalong/remove_WatchAlong.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

part 'watch_along_event.dart';
part 'watch_along_state.dart';

class WatchAlongFormBloc extends Bloc<WatchAlongEvent, WatchAlongState> {
  final CheckWatchAlong checkWatchAlong;
  final CreateWatchAlong createWatchAlong;
  final RemoveWatchAlong removeWatchAlong;

  WatchAlongFormBloc({@required this.checkWatchAlong,
   @required this.createWatchAlong,
    @required this.removeWatchAlong}) : super(WatchAlongInitial());


  @override
  Stream<WatchAlongState> mapEventToState(WatchAlongEvent event)
  async * {
    print('Incoming event: $event');
    if(event is ToggleScheduleWatchAlongEvent){
      print('Event is ${event.isScheduled}');
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
        print('WatchAlong ${response.getOrElse(null)}');
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
  }}
