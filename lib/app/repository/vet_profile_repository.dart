import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/user_model.dart';
import '../services/failure.dart';

abstract class VetProfileRepository {

  Future<Either<Failure, BaseResponse<PetsResponseModel>>> getPets(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> deletePets(Map<String, dynamic> map);

}