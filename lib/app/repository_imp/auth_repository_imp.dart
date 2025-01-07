import 'package:dartz/dartz.dart';
import '../../utils/Util.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/page_model.dart';
import '../data/models/user_model.dart';
import '../repository/auth_repository.dart';
import '../services/api_constants.dart';
import '../services/api_service.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';

class AuthRepositoryImpl extends AuthRepository {

  final ApiService _apiService = ApiService();

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> userLogin(Map<String, dynamic> map) async {

    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.login, data: map);
        // success
        // return either right
        // return data
        if(response.data['status'] == true){
          final data = BaseResponse
              .fromJson(
              response.data, (data) => UserModel.fromJson(data));
          return Right(data);
        } else {
          return Left(Failure(response.statusCode!, response.data['message']!));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {

      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> forgotPassword(Map<String, dynamic> map) async {
    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.forgotPassword, data: map);


        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => '');
          return Right(data);
        } else {
          return Left(Failure(response.statusCode!, response.data['message']!));
        }

      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> resendOTP(Map<String, dynamic> map) async {
    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.resendOtp, data: map);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => '');
          return Right(data);
        } else {
          return Left(Failure(response.statusCode!, response.data['message']!));
        }

      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> resetPassword(Map<String, dynamic> map) async {
    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.resetPassword, data: map);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => '');
          return Right(data);
        } else {
          return Left(Failure(response.statusCode!, response.data['message']!));
        }

      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> userSignUp(Map<String, dynamic> map) async {
    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.register, data: map);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => '');
          return Right(data);
        } else {
          return Left(Failure(response.statusCode!, response.data['message']!));
        }

      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {

      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<String>>> verifyOTP(Map<String, dynamic> map) async {
    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.verifyOtp, data: map);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(response.data, (data) => '');
          print(response.statusCode);
          return Right(data);
        } else {
          print(response.statusCode);
          print(response.data['message']!);
          return Left(Failure(response.statusCode!, response.data['message']!));
        }

      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      print(error);
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<UserModel>>> userSocialLogin(Map<String, dynamic> map) async {
    try {
      bool? isConnected =  await Util.check();
      if (isConnected) {

        final response = await _apiService.post(endPoint: ApiConstants.socialLogin, data: map);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(
              response.data, (data) => UserModel.fromJson(data));
          return Right(data);
        } else {
          return Left(Failure(response.statusCode!, response.data['message']!));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PageModel>>> getPage(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        final response = await _apiService.get(
            endPoint: '${ApiConstants.pages}${map['slug']}');



        if(response.data['status']){

          final data = BaseResponse.fromJson(
              response.data, (data) => PageModel.fromJson(data));

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