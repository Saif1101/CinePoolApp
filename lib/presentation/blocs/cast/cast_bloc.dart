import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/domain/usecases/movies/get_CastCrew.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/cast_entity.dart';
import 'package:socialentertainmentclub/entities/movie_params.dart';

part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;

  CastBloc({@required this.getCast}) : super(CastInitial())
  {
    on<LoadCastEvent>(_onLoadCastEvent); 
  }

  Future<void> _onLoadCastEvent(
    LoadCastEvent event, 
    Emitter<CastState> emit, 
  ) async {
    Either<AppError, List<CastEntity>> eitherResponse = await getCast(MovieParams(movieID: event.movieID));
      emit(
        eitherResponse.fold
        (
              (l) => CastError(), 
              (r) => CastLoaded(cast: r)
              )
      );
  }

  /* LEGACY mapEventToState
  @override
  Stream<CastState> mapEventToState(CastEvent event)
  async* {
    if(event is LoadCastEvent){
      Either<AppError, List<CastEntity>> eitherResponse = await getCast(MovieParams(movieID: event.movieID));
      yield eitherResponse.fold(
              (l) => CastError(), 
              (r) => CastLoaded(cast: r)
      );
    }

  }
  */

}
