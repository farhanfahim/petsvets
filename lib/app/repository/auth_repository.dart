
import '../data/models/common_models/base_response.dart';
import '../data/models/page_model.dart';
import '../data/models/user_model.dart';
import '../services/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {

  Future<Either<Failure, BaseResponse<UserModel>>> userLogin(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<UserModel>>> userSocialLogin(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<String>>> userSignUp(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<String>>> forgotPassword(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<String>>> verifyOTP(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<String>>> resendOTP(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<String>>> resetPassword(Map<String, dynamic> map);

  Future<Either<Failure, BaseResponse<PageModel>>> getPage(Map<String, dynamic> map);

}