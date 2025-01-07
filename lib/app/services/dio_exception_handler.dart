import 'package:dio/dio.dart';
import 'package:petsvet_connect/utils/Util.dart';

import '../components/custom_toast.dart';

class DioExceptionHandler {
  static void handleDioException(DioException dioException, {bool showToast = true}) {
    ///Need to do all network exception handling here
    String errorMessage = "An error occurred";

    print("Status code --> ${dioException.response?.statusCode}");

    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout";
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleResponseError(dioException.response!);
        break;
      case DioExceptionType.badCertificate:
        errorMessage = "Bad certificate error";
        break;
      case DioExceptionType.connectionError:
        errorMessage = "No Internet";
        break;
      case DioExceptionType.unknown:
        errorMessage = "An unexpected error occurred";
        break;
    }

    if (showToast) {
      Util.showAlert(title: errorMessage,error: true);
    }

    print("Error --> $errorMessage");
  }

  static String _handleResponseError(Response<dynamic> response) {
    // Customize this method based on your application's needs
    String errorMessage = response.data["message"];

    // You can add more detailed error handling based on status codes or response data

    return errorMessage;
  }
}
