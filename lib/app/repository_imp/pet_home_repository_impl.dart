import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:petsvet_connect/app/data/models/vet_detail_model.dart';
import '../../shared_prefrences/app_prefrences.dart';
import '../../utils/Util.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/vet_response_model.dart';
import '../repository/pet_home_repository.dart';
import '../services/api_constants.dart';
import '../services/api_service.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';

class PetHomeRepositoryImpl extends PetHomeRepository {

  final ApiService _apiService = ApiService();

  @override
  Future<Either<Failure, BaseResponse<VetResponseModel>>> getVets(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.get(
            endPoint: ApiConstants.getVets, params: map, headers: headers);




        
        log(jsonEncode(map));
        if(response.data['status']){
          final data = BaseResponse.fromJson(
              response.data, (data) => VetResponseModel.fromJson(data));
          return Right(data);
        } else {
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<VetData>>>> getNearbyVets(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.get(
            endPoint: ApiConstants.getVets, params: map, headers: headers);





        log(jsonEncode(map));
        if(response.data['status']){
          final data = BaseResponse<List<VetData>>.fromJson(
            response.data,
                (data) => (data as List<dynamic>)
                .map((item) => VetData.fromJson(item as Map<String, dynamic>))
                .toList(),
          );

          return Right(data);
        } else {
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<VetData>>>> getLimitedVets(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.get(
            endPoint: ApiConstants.getVets, params: map, headers: headers);





        log(jsonEncode(map));
        if(response.data['status']){
          final data = BaseResponse<List<VetData>>.fromJson(
            response.data,
                (data) => (data as List<dynamic>)
                .map((item) => VetData.fromJson(item as Map<String, dynamic>))
                .toList(),
          );

          return Right(data);
        } else {
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<VetDetailResponseModel>>> getVetDetail(int id,Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.get(
            endPoint: "${ApiConstants.getVetDetails}/$id", params: map, headers: headers);


        if(response.data['status']){
          final data = BaseResponse.fromJson(
              response.data, (data) => VetDetailResponseModel.fromJson(data));

          return Right(data);
        } else {
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

}