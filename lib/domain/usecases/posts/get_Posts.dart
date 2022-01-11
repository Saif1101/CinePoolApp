import 'package:dartz/dartz.dart';

import 'package:socialentertainmentclub/domain/repositories/posts_repository.dart';
import 'package:socialentertainmentclub/domain/usecases/usecase.dart';
import 'package:socialentertainmentclub/entities/app_error.dart';
import 'package:socialentertainmentclub/entities/no_params.dart';
import 'package:socialentertainmentclub/models/Post.dart';

class GetPosts extends UseCase<List<Post>,NoParams> {
  final PostsRepository repository;

  GetPosts(this.repository);

  @override
  Future<Either<AppError, List<Post>>> call(NoParams params) async {
    return await repository.getPosts();
  }
}
