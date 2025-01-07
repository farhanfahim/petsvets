import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../shared_prefrences/app_prefrences.dart';

class DioService {
  static final Dio _dio = Dio();

  static Future<Dio> getDio({
    Map? headers,
  }) async {
    var token = await AppPreferences.getAccessToken();
    // print("Token --> $token");

    // _dio.options.headers['Authorization'] = "Bearer $token";
    _dio.options.headers["x-access-token"] = token;

    if (headers != null) {
      if (headers.containsKey("Authorization")) {
        _dio.options.headers["Authorization"] = "Bearer ${headers["Authorization"]}";
      }

      if (headers.containsKey("x-access-token")) {
        _dio.options.headers["x-access-token"] = headers["x-access-token"];
      }

      _dio.options.headers['Content-Type'] = headers["Content-Type"];
      _dio.options.headers['Cache-Control'] = headers["Cache-Control"];
    }

    _dio.options.headers['Accept'] = "application/json";
    _dio.options.headers['Platform'] = Platform.isIOS ? "ios" : "android";
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          if (response.statusCode == 401 || response.statusCode == 423) {
            print("401 or 423");
          } else {
            handler.next(response);
          }
        },
        onError: (error, errorInterceptorHandler) async {
          if (error.response?.statusCode == 401 || error.response?.statusCode == 423) {
            print("401 or 423");
            // Util.showToast("Session Expired");
            // final MoreViewModel viewModel = Get.put(MoreViewModel());
            //
            // viewModel.logout();

            await AppPreferences.clearPreference();

            // await _uaePassPlugin.signOut();

            // Get.offAllNamed(Routes.LOGIN);

          } else {
            errorInterceptorHandler.next(error);
          }
        },
      ),
    );

    _dio.options;
    return _dio;
  }

}
