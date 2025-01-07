import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../utils/Util.dart';
import '../components/widgets/custom_progress_dialog.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pre_signed_model_response.dart';
import '../repository/media_upload_repository.dart';
import '../services/api_constants.dart';
import '../services/api_service.dart';
import '../services/env/env.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';

class MediaUploadRepositoryImpl extends MediaUploadRepository {

  final ApiService _apiService = ApiService();

  //final ProgressDialogController pd = ProgressDialogController(Get.context!);

  @override
  Future<Either<Failure,
      BaseResponse<PresignedUrlModelResponse>>> getBucketDetailsForFileUpload(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        //pd.show(text: 'Uploading Profile Picture',showProgress: false);

        var headers = {
          'x-access-token': Env.currentEnv.storagePresignedToken
        };

        final response = await _apiService.post(
            endPoint: ApiConstants.preSignedUrl, data: map, headers: headers);


        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => PresignedUrlModelResponse.fromJson(data));

          return Right(data);
        } else {
          //pd.hide();
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        //pd.hide();
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      //pd.hide();

      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile(
      Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {
        var headers = {
          'Content-Type': 'application/json',
          'x-access-token': Env.currentEnv.storagePresignedToken

        };

        dio.FormData formData = dio.FormData.fromMap({
          "ACL": map['acl'],
          "Content-Type": map['contentType'],
          "bucket": map['bucket'],
          "X-Amz-Algorithm": map['algorithm'],
          "X-Amz-Credential": map['credentials'],
          "X-Amz-Date": map['date'],
          "Key": map['key'],
          "Policy": map['policy'],
          "X-Amz-Signature": map['signature'],
          "file": await dio.MultipartFile.fromFile(map['image'], filename: map['fileName'],)
        });

        print(map);
        final response = await _apiService.post(
            endPoint: map['url'], data: formData, headers: headers, onSendProgress: (progress, total) {
          //pd.setProgress("${double.parse(((progress/total)*100).toString()).toStringAsFixed(2)}%");

        });
        print(map);
        print(map['url']);

        if(response.statusCode == 204){
          //pd.hide();
          print(response.headers);

          return Right(response.headers['location']![0]);
        } else {
          //pd.hide();
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        //pd.hide();
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      print(error);
      //pd.hide();
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

}