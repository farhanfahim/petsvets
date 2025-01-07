import 'package:dartz/dartz.dart';
import 'package:petsvet_connect/app/data/models/address_response_model.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_model.dart';
import '../services/failure.dart';

abstract class AddressRepository {

  Future<Either<Failure, BaseResponse<AddressResponseModel>>> getAddress(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> addAddress(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> deleteAddress(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> updateAddress(int id,Map<String, dynamic> map);

}