import 'package:arabic_testing/bloc/cubit/posts_cubit.dart';
import 'package:arabic_testing/models/post_model.dart';
import 'package:arabic_testing/repo/posts_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'posts_cubit_test.mocks.dart';

@GenerateMocks([PostsRepo])
void main() {
  late PostsRepo mockPostsRepo;
  late PostsCubit postsCubit;
  setUp(() {
    mockPostsRepo = MockPostsRepo();
    postsCubit = PostsCubit(mockPostsRepo);
  });
  test('get posts from cubit without any exception', () async{
    //arrange
    final postsList = List.generate(5, (index) => PostModel(
        id: index, userId: index, title: 'title $index', body: 'body $index'));
    when(mockPostsRepo.getPosts()).thenAnswer((_) async => Future.value(postsList));

 /* note: in cubit i write the assert before the act to check the emitted states */
  
 //assert
   // verify(mockPostsRepo.getPosts());
  //  expect(postsCubit.state, isA<PostsLoaded>());
  final expectedState = [
      
      const PostsLoading(),
      PostsLoaded(postsList)
    ];
    //if i use postsCubit only it will return an instance of the cubit not a state,so i use stream to emit the expected state in testing(actual),
    //so i can use expectLater to check if the cubit emits the expected state
    expectLater(postsCubit.stream, emitsInOrder(expectedState));
    //
 // expectLater(postsCubit, emits(PostsLoading()));

    //act
    postsCubit.getPosts();

   
  });

  test('get posts from cubit with exception', () async{
    //arrange
    when(mockPostsRepo.getPosts()).thenThrow(Exception('error'));
    final expectedState = [
      const PostsLoading(),
      const PostsError()
    ];
    expectLater(postsCubit.stream, emitsInOrder(expectedState));
    //act
    postsCubit.getPosts();
  });
  /* group('PostsCubit', () {
    test('initial state is PostsInitial', () {
      expect(postsCubit.state, PostsInitial());
    });
    test('getPosts', () {
      postsCubit.getPosts();
      expect(postsCubit.state, PostsLoading());
    });
  }); */
}
