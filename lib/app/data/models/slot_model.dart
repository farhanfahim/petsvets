import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SlotModel {
  List<SlotData>? data;

  SlotModel({ this.data});

  SlotModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SlotData>[];
      json['data'].forEach((v) { data!.add(new SlotData.fromJson(v)); });
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


class SlotData {
  int? id;
  int? duration;
  int? amount;
  RxBool? isSelected;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  SlotData({this.id, this.isSelected,this.duration, this.amount, this.createdAt, this.updatedAt, this.deletedAt, this.createdAgo});

  SlotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_ago'] = this.createdAgo;
    return data;
  }
}