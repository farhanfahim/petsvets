import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pre_signed_model_response.dart';
import '../services/failure.dart';

abstract class MediaUploadRepository {

  Future<Either<Failure, BaseResponse<PresignedUrlModelResponse>>> getBucketDetailsForFileUpload(Map<String, dynamic> map);

  Future<Either<Failure, String>> uploadFile(Map<String, dynamic> map);
}