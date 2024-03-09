part of 'posts_cubit.dart';

@immutable
sealed class PostsState {
  //i made it const to avoid creating a new object every time we create a new instance of the same type
  //this will help us to compare between two objects of the same type in any class extends this class
  const PostsState();
}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {
  const PostsLoading();
}

final class PostsLoaded extends PostsState {
  final List<PostModel> posts;
  const PostsLoaded(this.posts);
  @override
  //first we need to override the == operator to compare between two objects of the same type
  bool operator ==(Object other) {
    //if the two objects are the same object with hashcode and everything return true
    if (identical(this, other)) return true;
//if not check if the other object is of the same type and the posts list is equal to the other object posts list
    return other is PostsLoaded && listEquals(other.posts, posts);
  }

  @override
  int get hashCode => posts.hashCode;
}

final class PostsError extends PostsState {
  final String? message;
  const PostsError({this.message});
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostsError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
