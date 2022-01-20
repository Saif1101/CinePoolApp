

import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/WatchAlong.dart';

abstract class WatchAlongRepository{
  Future <Either<AppError,String>> checkWatchAlong(String movieID);
  Future <Either<AppError,void>> createWatchAlong(WatchAlong watchAlong);
  Future <Either<AppError,void>> optIntoWatchAlong(WatchAlong watchAlong);
  Future <Either<AppError,void>> optOutOfWatchAlong(WatchAlong watchAlong);
  Future <Either<AppError,bool>> checkIfParticipant(String watchAlongID);
  Future <Either<AppError,List<WatchAlong>>> getMyWatchAlongs();
  Future <Either<AppError,void>> deleteWatchAlong(String movieID, String watchAlongID);
}