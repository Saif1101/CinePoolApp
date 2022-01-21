import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/userandauth/get_UserFromID.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/check_IfParticipant.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/get_WatchAlongParticipants.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optInto_WatchAlong.dart';
import 'package:socialentertainmentclub/domain/usecases/watchalong/optOutOf_WatchAlong.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/UserModel.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

part 'watch_along_participation_event.dart';
part 'watch_along_participation_state.dart';

class WatchAlongParticipationBloc extends Bloc<WatchAlongParticipationEvent, WatchAlongParticipationState> {
  final OptIntoWatchAlong optIntoWatchAlong;
  final OptOutOfWatchAlong optOutOfWatchAlong;
  final CheckIfParticipant checkIfParticipant;
  final GetUserFromID getUserFromID;
  final GetWatchAlongParticipants getWatchAlongParticipants; 

  WatchAlongParticipationBloc({
    @required this.getUserFromID,
    @required this.getWatchAlongParticipants,
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

      List<UserModel> participants=[];

      final watchAlongParticipants = await getWatchAlongParticipants(event.watchAlong.watchAlongID);

       int errorFlag = 0;
      String errorMessage='';



      for(int i= 0; i<watchAlongParticipants.getOrElse(null).length; i++){
        final response = await getUserFromID(watchAlongParticipants.getOrElse(null).elementAt(i));
        if(response.isRight()){
         participants.add(response.getOrElse(null));
        } else {
          errorFlag = 1;
          errorMessage += "Error fetching participant user model;  ";
        }
      }
      
      if(errorFlag == 0){
        final response = await checkIfParticipant(event.watchAlong.watchAlongID);
        emit (response.fold(
          (l) => ParticipationButtonError(errorMessage: l.errorMessage + " Error while checking participation", appErrorType: l.appErrorType),
           (r) => IsParticipating(participants: participants, isParticipating: r)
           )
       );
      } else{
        emit(ParticipationButtonError(errorMessage: errorMessage));
      }
      
    }

    Future<void> _onCheckIfParticipationEvent(
      CheckIfParticipantEvent event,
      Emitter<WatchAlongParticipationState> emit, 
    ) async {
      List<UserModel> participants=[];

      final watchAlongParticipants = await getWatchAlongParticipants(event.watchAlongID);

       int errorFlag = 0;
      String errorMessage='';



      for(int i= 0; i<watchAlongParticipants.getOrElse(null).length; i++){
        final response = await getUserFromID(watchAlongParticipants.getOrElse(null).elementAt(i));
        if(response.isRight()){
         participants.add(response.getOrElse(null));
        } else {
          errorFlag = 1;
          errorMessage += "Error fetching participant user model;  ";
        }
      }
      
      if(errorFlag == 0){
        final response = await checkIfParticipant(event.watchAlongID);
        emit (response.fold(
          (l) => ParticipationButtonError(errorMessage: l.errorMessage + " Error while checking participation", appErrorType: l.appErrorType),
           (r) => IsParticipating(participants: participants, isParticipating: r)
           )
       );
      } else{
        emit(ParticipationButtonError(errorMessage: errorMessage));
      }
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
