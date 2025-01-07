import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/vet_detail_model.dart';
import '../data/models/vet_response_model.dart';
import '../services/failure.dart';

abstract class SearchRepository {
  Future<Either<Failure, BaseResponse<VetResponseModel>>> getVets(Map<String, dynamic> map);
}