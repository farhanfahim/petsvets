import 'package:get/get_rx/src/rx_types/rx_types.dart';

class VetResponseModel {
  Meta? meta;
  List<VetData>? data;

  VetResponseModel({this.meta, this.data});

  VetResponseModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <VetData>[];
      json['data'].forEach((v) {
        data!.add(new VetData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? firstPage;
  String? firstPageUrl;
  String? lastPageUrl;
  String? nextPageUrl;
  String? previousPageUrl;

  Meta(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.firstPage,
      this.firstPageUrl,
      this.lastPageUrl,
      this.nextPageUrl,
      this.previousPageUrl});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    firstPage = json['first_page'];
    firstPageUrl = json['first_page_url'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['first_page'] = this.firstPage;
    data['first_page_url'] = this.firstPageUrl;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['previous_page_url'] = this.previousPageUrl;
    return data;
  }
}

class VetData {
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
  RxString? address;
  RxBool? isSelected;
  String? alternatePhone;
  int? isCompleted;
  int? isSocialLogin;
  int? isApproved;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? pushNotification;
  int? trialAvailed;
  UserDetail? userDetail;
  UserImage? userImage;
  String? createdAgo;
  Meta? meta;

  VetData(
      {this.id,
      this.email,
      this.fullName,
      this.latitude,
      this.address,
      this.isSelected,
      this.longitude,
      this.isVerified,
      this.emergencyLocation,
      this.sharePetRecord,
      this.accessPharmacy,
      this.phone,
      this.alternatePhone,
      this.isCompleted,
      this.isSocialLogin,
      this.isApproved,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.pushNotification,
      this.trialAvailed,
      this.userDetail,
      this.userImage,
      this.createdAgo,
      this.meta});

  VetData.fromJson(Map<String, dynamic> json) {
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
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
    userImage = json['user_image'] != null
        ? new UserImage.fromJson(json['user_image'])
        : null;
    createdAgo = json['created_ago'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
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
  Null? deletedAt;
  String? startTime;
  String? endTime;
  String? createdAgo;
  Meta? meta;

  UserDetail(
      {this.id,
      this.vetType,
      this.stateLicenseNumber,
      this.stateLicense,
      this.nationalLicenseNumber,
      this.deaNumber,
      this.regNumber,
      this.about,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.startTime,
      this.endTime,
      this.createdAgo,
      this.meta});

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
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class UserImage {
  int? id;
  String? path;
  int? instanceType;
  int? instanceId;
  String? mimeType;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? duration;
  String? createdAgo;
  String? mediaUrl;
  String? smallImage;
  String? mediumImage;
  Meta? meta;

  UserImage(
      {this.id,
      this.path,
      this.instanceType,
      this.instanceId,
      this.mimeType,
      this.thumbnail,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.duration,
      this.createdAgo,
      this.mediaUrl,
      this.smallImage,
      this.mediumImage,
      this.meta});

  UserImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    instanceType = json['instance_type'];
    instanceId = json['instance_id'];
    mimeType = json['mime_type'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    duration = json['duration'];
    createdAgo = json['created_ago'];
    mediaUrl = json['mediaUrl'];
    smallImage = json['smallImage'];
    mediumImage = json['mediumImage'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['instance_type'] = this.instanceType;
    data['instance_id'] = this.instanceId;
    data['mime_type'] = this.mimeType;
    data['thumbnail'] = this.thumbnail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['duration'] = this.duration;
    data['created_ago'] = this.createdAgo;
    data['mediaUrl'] = this.mediaUrl;
    data['smallImage'] = this.smallImage;
    data['mediumImage'] = this.mediumImage;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}
