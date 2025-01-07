import 'package:dartz/dartz.dart';
import '../../shared_prefrences/app_prefrences.dart';
import '../../utils/Util.dart';
import '../data/models/common_models/base_response.dart';
import '../repository/cancel_appointment_repository.dart';
import '../services/api_constants.dart';
import '../services/api_service.dart';
import '../services/error_handler.dart';
import '../services/failure.dart';

class CancelAppointmentRepositoryImpl extends CancelAppointmentRepository {

  final ApiService _apiService = ApiService();
  @override
  Future<Either<Failure, BaseResponse<String>>> cancelAppointment(int id,Map<String, dynamic> map) async {
    try {
      bool? isConnected = await Util.check();
      if (isConnected) {

        var headers = {
          'Authorization': 'Bearer ${await AppPreferences.getAccessToken()}'
        };

        final response = await _apiService.patch(
            endPoint: "${ApiConstants.cancelAppointments}/$id", data: map, headers: headers);

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