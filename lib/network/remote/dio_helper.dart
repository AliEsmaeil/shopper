import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_view/core/constants/server_endpoints.dart';
import 'package:page_view/core/constants/shared_prefs_keys.dart';
import 'package:page_view/local_presistence/shared_preference.dart';
import 'package:page_view/utils/start_handler.dart';

class DioHelper {
  static late Dio dio;
  DioHelper() {
    initiateDio();
  }

  void initiateDio() {
    BaseOptions options = BaseOptions(
      baseUrl: ServerEndPoints.BASE_URL,
      receiveTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveDataWhenStatusError: true,
      contentType: 'application/json',
      headers: {
        'Content-Type': 'application/json',
      },
    );

    dio = Dio(options);

    dio.interceptors.add(
      LogInterceptor(
          request: true,
          requestBody: true,
          error: true,
          responseBody: true,
          logPrint: (ob) {}),
    );
  }

  static Future<Map<String, dynamic>> getData({
    required String endPointPath,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers['authorization'] = StartHandler.token;
    dio.options.headers['lang'] =
    (SharedPrefHelper.readData(key: SharedPreferenceConstants.directionality)?? false)
            ? 'ar'
            : 'en';

    return await dio
        .get(
      endPointPath,
      queryParameters: query,
    )
        .then((value) {
          print('data in dio = ${value.data}');
      return value.data;
    }).catchError((error) {
      debugPrint('error getting data in dio : error =  $error');
    });
  }

  static Future<Response> postData({
    required String endPointPath,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers['authorization'] = StartHandler.token;
    dio.options.headers['lang'] =
        SharedPrefHelper.readData(key: SharedPreferenceConstants.directionality)
            ? 'en'
            : 'ar';

    return await dio
        .post(
          endPointPath,
          data: data,
        )
        .then((value) => value)
        .catchError((error) => error);
  }

  static Future<Map<String, dynamic>> putData({
    required String endPointPath,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers['lang'] =
        SharedPrefHelper.readData(key: SharedPreferenceConstants.directionality)
            ? 'en'
            : 'ar';

    return await dio
        .put(endPointPath,
            data: data,
            options: Options(headers: {
              'Authorization': SharedPrefHelper.readData(
                  key: SharedPreferenceConstants.token),
            }))
        .then((value) => value.data)
        .catchError((error) {});
  }
}
