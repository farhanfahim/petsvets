import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/auth/login/views/login_view.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../shared_prefrences/app_prefrences.dart';

class DioFactory {
  static Dio? dio = Dio();

  static Dio? getDio() {

    dio!.options.headers['Accept'] = "application/json";
    dio!.options.headers['Content-Type'] = "application/json";
    dio!.options.connectTimeout = const Duration(milliseconds: 120*1000);
    dio!.options.receiveTimeout = const Duration(milliseconds: 120*1000);


    if (kDebugMode) {
      dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }


    dio!.interceptors.add(InterceptorsWrapper(onError: (error, _) async {
      print(error.response?.statusCode);

      if (error.response?.statusCode == 401) {

       AppPreferences.clearPreference();

       dio = null;

       Get.offAll(LoginView());
      }
    }));



    dio!.options;
    return dio;
  }
}