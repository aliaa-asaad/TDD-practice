import 'package:arabic_testing/bloc/cubit/posts_cubit.dart';
import 'package:arabic_testing/core/services/network_services.dart';
import 'package:arabic_testing/data_source/remote_data_source.dart';
import 'package:arabic_testing/models/post_model.dart';
import 'package:arabic_testing/repo/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
        PostsRepoImpl(
          RemoteDataSourceImpl(networkServices: 
            NetworkServicesImpl()),
        ),
      )..getPosts(),
      child: Scaffold(body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      //listen when the state is changed it return a new thing
      // i want to do like show a dialog or navigate to another page
      listener: (context, state) {
        if (state is PostsError) _showErrorDialog(context);
      },
      builder: (context, state) {
        if (state is PostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsLoaded) {
          return _buildPostsList(state);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPostsList(PostsLoaded state) {
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (_, index) {
        final post = state.posts[index];
        return _PostItem(post);
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('An error occurred!'),
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final PostModel _post;
  const _PostItem(this._post);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(_post.id.toString()),
      title: Text(_post.title),
      subtitle: Text(_post.body),
    );
  }
}