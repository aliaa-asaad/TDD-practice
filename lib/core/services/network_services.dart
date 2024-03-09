import 'package:dio/dio.dart';

abstract class NetworkServices {
  Future<Response> get(String url, /* {Map<String, String> headers} */);
  Future<Response> post(String url, dynamic body/* {/* Map<String, String> headers, */ } */);
  /* Future<dynamic> put(String url, {/* Map<String, String> headers, */ dynamic body});
  Future<dynamic> delete(String url,/*  {Map<String, String> headers} */); */
}
class NetworkServicesImpl extends NetworkServices {
  final Dio client=Dio();
  
  @override
  Future<Response> get(String url, /* {Map<String, String> headers} */) async {
    final response = await client.get(url, /* headers: headers */);
    return response.data;
  }
  @override
  Future<Response> post(String url, dynamic body/* {/* Map<String, String> headers, */ } */) async {
    final response = await client.post(url, /* headers: headers, */ data: body);
    return response;
  }
 /*  @override
  Future<dynamic> put(String url, {Map<String, String> headers, dynamic body}) async {
    final response = await client.put(url, headers: headers, body: body);
    return response;
  }
  @override
  Future<dynamic> delete(String url, {Map<String, String> headers}) async {
    final response = await client.delete(url, headers: headers);
    return response;
  } */
}