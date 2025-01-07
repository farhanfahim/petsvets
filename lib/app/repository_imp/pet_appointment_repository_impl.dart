import 'package:dartz/dartz.dart';
import '../../shared_prefrences/app_prefrences.dart';
import '../../utils/Util.dart';
import '../data/models/appointment_model.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/user_model.dart';
import '../data/models/vet_response_model.dart';
import '../repository/change_password_repository.dart';
import '../repository/pet_appointment_repository.dart';
import '../repository/pet_edit_profile_repository.dart';
import '../repository/pet_profile_repository.dart';
import '../repository/vet_home_repository.dart';
import '../repository/vet_profile_repository.dart';
import '../services/api_constants.dart';
import '../services/api_service.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';

class PetAppointmentRepositoryImpl extends PetAppointmentRepository {

  final ApiService _apiService = ApiService();

  @override
  Future<Either<Failure, BaseResponse<AppointmentModel>>> getAppointments(Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        print(ApiConstants.appointments);
        print(map);
        final response = await _apiService.get(
            endPoint: ApiConstants.appointments, params: map, headers: headers);



        if(response.data['status']){
          final data = BaseResponse
              .fromJson(
              response.data, (data) => AppointmentModel.fromJson(data));
          return Right(data);
        } else {
          print(response);
          return Left(await handleUnAuthorizedError(response));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      print(error);
      return Left(ErrorHandler
          .handle(error)
          .failure);
    }
  }

}