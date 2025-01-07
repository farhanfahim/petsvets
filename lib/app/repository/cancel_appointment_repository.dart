import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../services/failure.dart';

abstract class CancelAppointmentRepository {

  Future<Either<Failure, BaseResponse<String>>> cancelAppointment(int id,Map<String, dynamic> map);

}