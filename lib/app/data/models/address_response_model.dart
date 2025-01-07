import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AddressResponseModel {
  Meta? meta;
  List<AddressData>? data;

  AddressResponseModel({this.meta, this.data});

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) { data!.add(new AddressData.fromJson(v)); });
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

  Meta({this.total, this.perPage, this.currentPage, this.lastPage, this.firstPage, this.firstPageUrl, this.lastPageUrl, this.nextPageUrl, this.previousPageUrl});

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

class AddressData {
  int? id;
  double? latitude;
  double? longitude;
  int? isDefault;
  RxBool? isSelected;
  int? userId;
  String? address;
  String? city;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;
  Meta? meta;

  AddressData({this.id, this.isSelected,this.latitude, this.longitude, this.address,this.city,this.isDefault, this.userId, this.createdAt, this.updatedAt, this.deletedAt, this.createdAgo, this.meta});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_default'] = this.isDefault;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_ago'] = this.createdAgo;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}