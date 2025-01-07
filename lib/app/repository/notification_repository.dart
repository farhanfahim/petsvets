import 'package:dartz/dartz.dart';
import '../data/models/common_models/base_response.dart';
import '../data/models/notification_model.dart';
import '../data/models/pet_response_model.dart';
import '../data/models/user_model.dart';
import '../data/models/vet_response_model.dart';
import '../services/failure.dart';

abstract class NotificationRepository {

  Future<Either<Failure, BaseResponse<NotificationModel>>> getNotifications(Map<String, dynamic> map);
  Future<Either<Failure, BaseResponse<String>>> markReadNotifications(Map<String, dynamic> map);

}