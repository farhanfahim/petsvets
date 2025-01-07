import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/user_model.dart';
import '../services/failure.dart';

abstract class VetEditProfileRepository {

  Future<Either<Failure, BaseResponse<User>>> updateProfile(Map<String, dynamic> map);

}