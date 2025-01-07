import 'package:dartz/dartz.dart';
import '../data/models/appointment_model.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/user_model.dart';
import '../data/models/vet_response_model.dart';
import '../services/failure.dart';

abstract class PetAppointmentRepository {

  Future<Either<Failure, BaseResponse<AppointmentModel>>> getAppointments(Map<String, dynamic> map);

}