import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;
import 'package:petsvet_connect/app/modules/auth/login/views/login_view.dart';

import '../../config/translations/strings_enum.dart';
import '../../shared_prefrences/app_prefrences.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = handleError(error);
    } else if(error is SocketException) {

      failure = DataSource.NO_INTERNET_CONNECTION.getFailure();
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0, error.response?.data["message"] ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

Future<Failure> handleUnAuthorizedError(Response response) async {
  if(response.statusCode == 401){
    AppPreferences.clearPreference();

    if(getX.Get.currentRoute != LoginView()){
      getX.Get.offAll(LoginView());
    }
  }
  return Failure(response.statusCode!, response.data['message']!);
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}



extension DataSourceExtension on DataSource {
  Failure getFailure() {
    // var mContext = navigatorKey!.currentState!.context;
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.success);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.noContent);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.badRequest);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.forbidden);
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.unAuthorized);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.notFound);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.internalServerError);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.connectTimeout);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.cancel);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.receiveTimeout);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.sendTimeout);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.cacheError);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.noInternetConnection);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.default_);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String success = Strings.success; // success with data
  static const String noContent = Strings.success; // success with no data (no content)
  static const String badRequest = Strings.strBadRequestError; // failure, API rejected request
  static const String unAuthorized = Strings.strUnauthorizedError; // failure, user is not authorised
  static const String forbidden = Strings.strForbiddenError; //  failure, API rejected request
  static const String internalServerError = Strings.strInternalServerError; // failure, crash in server side
  static const String notFound = Strings.strNotFoundError; // failure, crash in server side

  // local status code
  static const String connectTimeout = Strings.strTimeoutError;
  static const String cancel = Strings.strDefaultError;
  static const String receiveTimeout = Strings.strTimeoutError;
  static const String sendTimeout = Strings.strTimeoutError;
  static const String cacheError = Strings.strCacheError;
  static const String noInternetConnection = Strings.strNoInternetError;
  static const String default_ = Strings.strDefaultError;
}
