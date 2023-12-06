import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/constants/strings.dart';

class WebServices {
   late Dio dio;

  WebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    dio = Dio(baseOptions);
    dio.interceptors.add(
      LogInterceptor(
        error: true,
       // request: true,
      ),
    );
  }


   Future<Response> getData({required String url,  Map<String, dynamic>? query}) async{
    try{ Response response =await dio.get(url, queryParameters: query);
    return response;}on DioError catch(e){
      return e.response!;
    }
    catch (e) {
      throw HttpException(e.toString());
    }

  }
}
