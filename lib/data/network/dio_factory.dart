import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constant.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content_type';
const String AUTHORIZATION = 'authorization';
const String ACCEPT = 'accept';

//1
class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    int _timeout = 60 * 1000; //1 min
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.apiKey,
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      headers: headers,
    );

    if (kReleaseMode) {
      print('release mode no logs');
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
