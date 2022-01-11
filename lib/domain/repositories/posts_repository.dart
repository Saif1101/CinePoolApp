import 'package:dartz/dartz.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/models/Post.dart';

abstract class PostsRepository{
  Future <Either<AppError, List<Post>>> getPosts();
}