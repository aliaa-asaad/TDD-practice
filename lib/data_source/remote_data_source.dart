import 'package:arabic_testing/core/services/network_services.dart';
import 'package:arabic_testing/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> get(String url);
  Future<dynamic> post(String url, dynamic body);
  /* Future<dynamic> put(String url, dynamic body);
  Future<dynamic> delete(String url); */
}
class RemoteDataSourceImpl extends RemoteDataSource {
  final NetworkServices networkServices;
  RemoteDataSourceImpl({required this.networkServices});
  @override
  Future<List<PostModel>> get(String url) async {
    final response = await networkServices.get(url);
    if(response.statusCode!=200){
      throw Exception('error');
    }
    final List<PostModel> posts = (response.data as List)
        .map((post) => PostModel.fromJson(post))
        .toList();
    return posts;
  }
  @override
  Future<dynamic> post(String url, dynamic body) async {
    final response = await networkServices.post(url, body);
    return response;
  }
  /* @override
  Future<dynamic> put(String url, dynamic body) async {
    final response = await networkServices.put(url, body);
    return response;
  }
  @override
  Future<dynamic> delete(String url) async {
    final response = await networkServices.delete(url);
    return response;
  } */
}