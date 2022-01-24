import 'package:bitnxt/constants/config.dart';
import 'package:bitnxt/utils/appurl.dart';
import 'package:dio/dio.dart';

class HttpService {
  Dio _dio = Dio();

  final baseUrl = "https://reqres.in/";

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: AppUrl.baseUrl, headers: {
      "Content-Type": "application/json",
      "X-Api-Key": API_KEY,
    }));

    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest(String endpoint, Map data) async {
    Response response;
    try {
      response = await _dio.post(baseUrl, data: data);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) {
      print(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      return handler.next(e);
    }, onRequest: (options, handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }));
  }
}
