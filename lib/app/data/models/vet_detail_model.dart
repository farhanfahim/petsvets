import 'package:petsvet_connect/app/data/models/user_model.dart';

class VetDetailResponseModel {
  int? id;
  String? email;
  String? fullName;
  double? latitude;
  double? longitude;
  int? isVerified;
  int? emergencyLocation;
  int? sharePetRecord;
  int? accessPharmacy;
  String? phone;
  String? alternatePhone;
  int? isCompleted;
  int? isSocialLogin;
  int? isApproved;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? pushNotification;
  int? trialAvailed;
  UserImage? userImage;
  UserDetail? userDetail;
  String? createdAgo;

  VetDetailResponseModel({this.id, this.userImage,this.email, this.fullName, this.latitude, this.longitude, this.isVerified, this.emergencyLocation, this.sharePetRecord, this.accessPharmacy, this.phone, this.alternatePhone, this.isCompleted, this.isSocialLogin, this.isApproved, this.createdAt, this.updatedAt, this.deletedAt, this.pushNotification, this.trialAvailed, this.userDetail, this.createdAgo});

  VetDetailResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isVerified = json['is_verified'];
    emergencyLocation = json['emergency_location'];
    sharePetRecord = json['share_pet_record'];
    accessPharmacy = json['access_pharmacy'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    isCompleted = json['is_completed'];
    isSocialLogin = json['is_social_login'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pushNotification = json['push_notification'];
    trialAvailed = json['trial_availed'];
    userImage = json['user_image'] != null ? new UserImage.fromJson(json['user_image']) : null;
    userDetail = json['user_detail'] != null ? new UserDetail.fromJson(json['user_detail']) : null;
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_verified'] = this.isVerified;
    data['emergency_location'] = this.emergencyLocation;
    data['share_pet_record'] = this.sharePetRecord;
    data['access_pharmacy'] = this.accessPharmacy;
    data['phone'] = this.phone;
    data['alternate_phone'] = this.alternatePhone;
    data['is_completed'] = this.isCompleted;
    data['is_social_login'] = this.isSocialLogin;
    data['is_approved'] = this.isApproved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['push_notification'] = this.pushNotification;
    data['trial_availed'] = this.trialAvailed;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    if (this.userImage != null) {
      data['user_image'] = this.userImage!.toJson();
    }
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class UserDetail {
  int? id;
  int? vetType;
  String? stateLicenseNumber;
  String? stateLicense;
  String? nationalLicenseNumber;
  String? deaNumber;
  String? regNumber;
  String? about;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? startTime;
  String? endTime;
  String? createdAgo;

  UserDetail({this.id, this.vetType, this.stateLicenseNumber, this.stateLicense, this.nationalLicenseNumber, this.deaNumber, this.regNumber, this.about, this.userId, this.createdAt, this.updatedAt, this.deletedAt, this.startTime, this.endTime, this.createdAgo});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vetType = json['vet_type'];
    stateLicenseNumber = json['state_license_number'];
    stateLicense = json['state_license'];
    nationalLicenseNumber = json['national_license_number'];
    deaNumber = json['dea_number'];
    regNumber = json['reg_number'];
    about = json['about'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vet_type'] = this.vetType;
    data['state_license_number'] = this.stateLicenseNumber;
    data['state_license'] = this.stateLicense;
    data['national_license_number'] = this.nationalLicenseNumber;
    data['dea_number'] = this.deaNumber;
    data['reg_number'] = this.regNumber;
    data['about'] = this.about;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}
