import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/vet_detail_model.dart';
import '../data/models/vet_response_model.dart';
import '../services/failure.dart';

abstract class PetHomeRepository {

  Future<Either<Failure, BaseResponse<VetResponseModel>>> getVets(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<List<VetData>>>> getLimitedVets(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<List<VetData>>>> getNearbyVets(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<VetDetailResponseModel>>> getVetDetail(int id,Map<String, dynamic> map);

}