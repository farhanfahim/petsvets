import 'package:dartz/dartz.dart';
import '../data/models/breed_model.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_model.dart';
import '../services/failure.dart';

abstract class PetPostRegistrationRepository {

  Future<Either<Failure, BaseResponse<PetModel>>> getPet(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<BreedModel>>> getBreed(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> addPetRecord(Map<String, dynamic> map);

}