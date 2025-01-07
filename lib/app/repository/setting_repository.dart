import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../services/failure.dart';

abstract class SettingRepository {

  Future<Either<Failure, BaseResponse<String>>> logout(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> toggleNotification(Map<String, dynamic> map);

}