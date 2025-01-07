import 'package:dartz/dartz.dart';
import 'package:petsvet_connect/app/data/models/scheduled_model.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/slot_model.dart';
import '../data/models/user_model.dart';
import '../services/failure.dart';

abstract class SlotRepository {

  Future<Either<Failure, BaseResponse<SlotModel>>> getAdminSlots(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<ScheduledModel>>> getScheduledSlots(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> addFullTimeSlot(Map<String, dynamic> map);

}