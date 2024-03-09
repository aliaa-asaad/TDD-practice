import 'package:arabic_testing/core/constants/end_points.dart';
import 'package:arabic_testing/data_source/remote_data_source.dart';
import 'package:arabic_testing/models/post_model.dart';

abstract class PostsRepo {
  Future<List<PostModel>> getPosts();
}

class PostsRepoImpl extends PostsRepo {
  final RemoteDataSource _remoteDataSource;

  PostsRepoImpl(this._remoteDataSource);
  @override
  Future<List<PostModel>> getPosts() {
   return _remoteDataSource.get(EndPoints.posts);
  }
}
