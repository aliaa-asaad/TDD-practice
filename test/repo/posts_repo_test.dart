import 'package:arabic_testing/core/constants/end_points.dart';
import 'package:arabic_testing/data_source/remote_data_source.dart';
import 'package:arabic_testing/models/post_model.dart';
import 'package:arabic_testing/repo/posts_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'posts_repo_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late PostsRepo postsRepo;
  late RemoteDataSource mockRemoteDataSource;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    postsRepo = PostsRepoImpl(mockRemoteDataSource);
  });
  test('get posts from posts repo without any exception', ()async {
    //arrange
    List<PostModel> postsList = List.generate(
        5,
        (index) => PostModel(
            id: index,
            userId: index,
            title: 'title $index',
            body: 'body $index'));
    
    when(mockRemoteDataSource.get(EndPoints.posts)).thenAnswer((_) async => Future.value(postsList));
    //act
    final result =await postsRepo.getPosts();
    //assert
    //  verify(mockRemoteDataSource.getPosts());
    expect(result, postsList);
  });
}
