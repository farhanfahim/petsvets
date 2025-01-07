import 'package:dartz/dartz.dart';
import '../data/models/breed_model.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_model.dart';
import '../services/failure.dart';

abstract class VetPostRegistrationRepository {

  Future<Either<Failure, BaseResponse<String>>> addVetRecord(Map<String, dynamic> map);

}