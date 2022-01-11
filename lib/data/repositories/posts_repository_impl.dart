import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:socialentertainmentclub/data_sources/posts_remote_dataSource.dart';
import 'package:socialentertainmentclub/domain/repositories/posts_repository.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/Post.dart';

class PostsRepositoryImpl extends PostsRepository{
  final PostsRemoteDataSource postsRemoteDataSource;

  PostsRepositoryImpl({@required this.postsRemoteDataSource});

  @override
  Future<Either<AppError, List<Post>>> getPosts() async {
    try{
      final posts = await postsRemoteDataSource.getPosts();
      return Right(posts);
    } on SocketException{
      return Left(AppError(appErrorType: AppErrorType.network));
    } on Exception catch(e){
      return Left(AppError(appErrorType: AppErrorType.authentication, errorMessage: e.toString()));
    }
  }
  }
