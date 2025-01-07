import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/user_model.dart';
import '../services/failure.dart';

abstract class VetHomeRepository {

  Future<Either<Failure, BaseResponse<PetsResponseModel>>> getAppointments(Map<String, dynamic> map);

}