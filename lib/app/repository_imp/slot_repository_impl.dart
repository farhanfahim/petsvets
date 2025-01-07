import 'package:dartz/dartz.dart';
import 'package:petsvet_connect/app/data/models/scheduled_model.dart';
import '../../shared_prefrences/app_prefrences.dart';
import '../../utils/Util.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/slot_model.dart';
import '../repository/slot_repository.dart';
import '../services/api_constants.dart';
import '../services/api_service.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';

class SlotRepositoryImpl extends SlotRepository {

  final ApiService _apiService = ApiService();

  @override
  Future<Either<Failure, BaseResponse<SlotModel>>> getAdminSlots(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.get(
            endPoint: ApiConstants.slots, data: map, headers: headers);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(
              response.data, (data) => SlotModel.fromJson(data));
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
  Future<Either<Failure, BaseResponse<ScheduledModel>>> getScheduledSlots(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };
        print(ApiConstants.getScheduleSlots);
        print(map);
        final response = await _apiService.get(
            endPoint: ApiConstants.getScheduleSlots, params: map, headers: headers);




        print(response);
        if(response.data['status']){
          final data = BaseResponse
              .fromJson(
              response.data, (data) => ScheduledModel.fromJson(data));
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
  Future<Either<Failure, BaseResponse<String>>> addFullTimeSlot(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.post(
            endPoint: ApiConstants.scheduleSlots, data: map, headers: headers);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => '');
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