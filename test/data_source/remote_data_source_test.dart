import 'package:arabic_testing/core/constants/end_points.dart';
import 'package:arabic_testing/core/services/network_services.dart';
import 'package:arabic_testing/data_source/remote_data_source.dart';
import 'package:arabic_testing/models/post_model.dart';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_data_source_test.mocks.dart';

//it takes a list of classes and generate the mocks for them
//instead of writing the mocks manually or using constructors as a value of objects
@GenerateMocks([NetworkServices])

/* 
use this command:flutter pub run  build_runner build --delete-conflicting-outputs
to build mokito class for any class in GenerateMoks list aith the same methods in any class of them
and delete any duplicated testing class using build_runner package */
void main() {
  /////////////
  ///كان في ايرور فالفيديو بسبب الفاينال وقال انها عشان محطوطة والفاريابل واخد قيمة 
  ///فكدا اما يعمل التيست التاني هيلاقيه واخد قيمة ..طب ازاي والمفروض السيت اب بتلغي الاوبجكت وبعديت تكريته تاني
  /////////
  late  RemoteDataSource remoteDataSource /* = RemoteDataSourceImpl() */;
  late  NetworkServices networkServices /* = NetworkServicesImpl() */;
  setUp(() {
    //the networkServices is a mock object that has the same methods of the NetworkServices class
    // and it's used to test the RemoteDataSourceImpl class without using the real NetworkServices class
    // to avoid any error from the api in testing
    networkServices = MockNetworkServices();

    remoteDataSource = RemoteDataSourceImpl(networkServices: networkServices);
  });
  test('get posts without exception', () async{
    //arrange
/* from line 34-56 i'm just mocking the data that i want to get from the api by 
making a reversed process of the usual process in getting data :
converting List<PostModel> (the result or usual data i wanna return in usual process)
to a List< Map<String,dynamic>>(the usual JSON data returning from the api and i convert it in usual proccess) */
    //expectedPosts is the real value or the expected value of the get method in reality(List<PostModel>) (matcher)
    final expectedPosts = List.generate(
        5,
        (index) => PostModel(
            id: index,
            userId: index,
            title: 'title $index',
            body: 'body $index'));

    //the url is the url of the api that we want to test
   
/* the postsMap is a list of the expected value of the posts that we want to get from the api
as the json from the api is just a map and i convert it to an object of model */
//this line is to convert the expectedPosts to a list of maps as the api will give me the data in this form at first
    final List<Map<String, dynamic>> postsMap =
        expectedPosts.map((postModel) => postModel.toJson()).toList();
    /* explaination :
    networkServices doesn't know how or where it will give me the mocked data i want so,
     i tell the networkServices that when i call the method 'get' from it then give me a future value,
    the future value is a response that is just like the real response from api 
    ,but the difference that i determine this response with its data(it's the postsMap that i want to get from the api),
    request options( take the path where it will get the data from ), and status code*/
    ///////////////
    ///حاسة اني مش لاقطة اهمية الموك غير انه كريت كلاس مكان النيتورك كلاس العادي لاني كاني عملت ميثود الجيت بايدي فهو كدا عمل ايه
    /////////////////
    when(networkServices.get(EndPoints.posts)).thenAnswer(
      (_) async => Future.value(
        Response(
          requestOptions: RequestOptions(path: EndPoints.posts),
          data: postsMap,
          statusCode: 200,
        ),
      ),
    );
    //act
    //the actual data from my test
    final result = await remoteDataSource.get(EndPoints.posts);

    //assest
    expect(result,expectedPosts);
  });
  
  test('GetPosts should throw an Exception if the status code is not 200',
      () async {
    //arrange
    final expectedResult = throwsA(isA<Exception>());
    
    when(networkServices.get(EndPoints.posts))
        .thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(
              path: EndPoints.posts),
          statusCode: 404,
        ),
      ),
    );

    //act
    result() async => await remoteDataSource.get(EndPoints.posts);

    //assert
    expect(result, expectedResult);
  });
}
