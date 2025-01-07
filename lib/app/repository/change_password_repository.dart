import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../services/failure.dart';

abstract class ChangePasswordRepository {

  Future<Either<Failure, BaseResponse<String>>> changePassword(Map<String, dynamic> map);

}