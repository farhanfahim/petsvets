import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/scheduled_model.dart';
import '../services/failure.dart';

abstract class ScheduleRepository {

  Future<Either<Failure, BaseResponse<PetsResponseModel>>> getPets(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<ScheduledModel>>> getScheduledSlots(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> scheduledAppointment(Map<String, dynamic> map);

}