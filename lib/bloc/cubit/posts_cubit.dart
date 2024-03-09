import 'package:arabic_testing/models/post_model.dart';
import 'package:arabic_testing/repo/posts_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo _postsRepo;
  PostsCubit(this._postsRepo) : super(PostsInitial());
  Future<void> getPosts() async {
    emit(const PostsLoading());
    try {
      final posts = await _postsRepo.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(const PostsError());
    }
  }
}
