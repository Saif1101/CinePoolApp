import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_IfParticipant.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optInto_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optOutOf_WatchAlong.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

part 'watch_along_participation_event.dart';
part 'watch_along_participation_state.dart';

class WatchAlongParticipationBloc extends Bloc<WatchAlongParticipationEvent, WatchAlongParticipationState> {
  final OptIntoWatchAlong optIntoWatchAlong;
  final OptOutOfWatchAlong optOutOfWatchAlong;
  final CheckIfParticipant checkIfParticipant;

  WatchAlongParticipationBloc({
    @required this.optIntoWatchAlong,
    @required this.optOutOfWatchAlong,
    @required this.checkIfParticipant}) : super(WatchAlongParticipationInitial()){
      on<ToggleParticipationEvent>(_onToggleParticipationEvent); 
      on<CheckIfParticipantEvent>(_onCheckIfParticipationEvent); 
    }

    Future<void> _onToggleParticipationEvent(
      ToggleParticipationEvent event, 
      Emitter<WatchAlongParticipationState> emit, 
    ) async {
      emit(ParticipationButtonLoading());
      if (event.isParticipating) {
        await optOutOfWatchAlong(event.watchAlong);
      } else {
        await optIntoWatchAlong(event.watchAlong);
      }
      final response = await checkIfParticipant(event.watchAlong.watchAlongID);
      emit (response.fold(
          (l) => ParticipationButtonError(),
           (r) => IsParticipating(r)
           )
          );
    }

    Future<void> _onCheckIfParticipationEvent(
      CheckIfParticipantEvent event,
      Emitter<WatchAlongParticipationState> emit, 
    ) async {
      final response = await checkIfParticipant(event.watchAlongID);
      emit(response.fold(
              (l) => ParticipationButtonError(), 
              (r) => IsParticipating(r) )
      );
    }

    /* LEGACY mapEventToState
  @override
  Stream<WatchAlongParticipationState> mapEventToState(
      WatchAlongParticipationEvent event) async* {
    if (event is ToggleParticipationEvent) {
      yield ParticipationButtonLoading();
      if (event.isParticipating) {
        await optOutOfWatchAlong(event.watchAlong);
      } else {
        await optIntoWatchAlong(event.watchAlong);
      }
      final response = await checkIfParticipant(event.watchAlong.watchAlongID);
      yield response.fold(
          (l) => ParticipationButtonError(), (r) => IsParticipating(r));
    } else if (event is CheckIfParticipantEvent){
      final response = await checkIfParticipant(event.watchAlongID);
      yield response.fold(
              (l) => ParticipationButtonError(), 
              (r) => IsParticipating(r)
      );
    }
  }
  */
}
