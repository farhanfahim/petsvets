import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PetsResponseModel {
  List<Data>? data;

  PetsResponseModel({this.data});

  PetsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? breedId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? breed;
  RxBool? isSelected;
  String? createdAgo;

  Data({this.id, this.name, this.isSelected,this.breedId, this.userId, this.createdAt, this.updatedAt, this.deletedAt, this.breed, this.createdAgo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    breedId = json['breed_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    breed = json['breed'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['breed_id'] = this.breedId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['breed'] = this.breed;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}