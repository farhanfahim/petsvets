import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as getX;
import 'package:petsvet_connect/app/modules/auth/login/views/login_view.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../shared_prefrences/app_prefrences.dart';
class ApiService {

  Dio? _dio = Dio();


  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {

    return _instance;
  }

  // static final Dio? _dio = DioFactory.getDio();

  static const int TIME_OUT_DURATION = 500000; // in milliseconds

  void init() {
    _dio!.options.headers['Accept'] = "application/json";
    _dio!.options.headers['Content-Type'] = "application/json";
    _dio!.options.connectTimeout = const Duration(milliseconds: TIME_OUT_DURATION);
    _dio!.options.receiveTimeout = const Duration(milliseconds: TIME_OUT_DURATION);


    if (kDebugMode) {
      _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    _dio!.interceptors.add(InterceptorsWrapper(onError: (error, _) async {

      print(error);
      if (error.response?.statusCode == 401) {

        print('HERE');
        AppPreferences.clearPreference();

        _dio = null;


        getX.Get.offAll(LoginView());
      } else {

        print('HERE123');
        _.next(error);
      }
    }));

  }

  Future<Response> get({required String endPoint, dynamic data, dynamic params, dynamic headers}) async {
    try {

      var response = await _dio!.get(endPoint, data: data,
        queryParameters: params,
        options: Options(headers: headers,
          validateStatus: (status) {
            // Consider any status code less than 500 as valid
            return status != null && status <= 502;
          },),);

      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Response> post(
      {required String endPoint, dynamic data, dynamic headers,
        Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
        Function(int total, int progress)? onReceiveProgress,
      }) async {
    try{
      var response = await _dio!.post(
        endPoint,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(headers: headers,
          receiveTimeout: const Duration(milliseconds: TIME_OUT_DURATION),
          sendTimeout: const Duration(milliseconds: TIME_OUT_DURATION),
          validateStatus: ( status ) {

            return status != null && status <= 502;
          },
        ),
      );
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Response> patch(
      {required String endPoint, dynamic data, dynamic headers,
        Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
        Function(int total, int progress)? onReceiveProgress,
      }) async {
    try {
      var response = await _dio!.patch(
        endPoint,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(headers: headers,
          receiveTimeout: const Duration(milliseconds: TIME_OUT_DURATION),
          sendTimeout: const Duration(milliseconds: TIME_OUT_DURATION),
          validateStatus: (status) {
            // Consider any status code less than 500 as valid
            return status != null && status <= 502;
          },),
      );
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Response> put(
      {required String endPoint, dynamic data, dynamic headers,
        Function(int total, int progress)? onSendProgress, // while sending (uploading) progress
        Function(int total, int progress)? onReceiveProgress,
      }) async {
    try {
      var response = await _dio!.put(
        endPoint,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: Options(headers: headers,
            receiveTimeout: const Duration(milliseconds: TIME_OUT_DURATION),
            sendTimeout: const Duration(milliseconds: TIME_OUT_DURATION)),
      );
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<Response> delete(
      {
        required String endPoint, dynamic param, dynamic headers,
      }) async {
    try {
      var response = await _dio!.delete(
        endPoint,
              queryParameters: param,
        options: Options(headers: headers,
            receiveTimeout: const Duration(milliseconds: TIME_OUT_DURATION),
            sendTimeout: const Duration(milliseconds: TIME_OUT_DURATION)),
      );
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}