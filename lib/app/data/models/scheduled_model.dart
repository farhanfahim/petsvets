import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ScheduledModel {
  int? id;
  int? vetId;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? type;
  List<ScheduleSlots>? scheduleSlots;
  String? createdAgo;

  ScheduledModel({this.id, this.vetId, this.date, this.createdAt, this.updatedAt, this.deletedAt, this.type, this.scheduleSlots, this.createdAgo});

  ScheduledModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vetId = json['vet_id'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    type = json['type'];
    if (json['schedule_slots'] != null) {
      scheduleSlots = <ScheduleSlots>[];
      json['schedule_slots'].forEach((v) { scheduleSlots!.add(new ScheduleSlots.fromJson(v)); });
    }
    createdAgo = json['created_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vet_id'] = this.vetId;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['type'] = this.type;
    if (this.scheduleSlots != null) {
      data['schedule_slots'] = this.scheduleSlots!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class ScheduleSlots {
  int? id;
  int? scheduleId;
  int? slotId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Slot? slot;
  List<ScheduleSlotTimes>? scheduleSlotTimes;
  String? createdAgo;

  ScheduleSlots({this.id, this.scheduleId, this.scheduleSlotTimes,this.slotId, this.createdAt, this.updatedAt, this.deletedAt, this.slot, this.createdAgo});

  ScheduleSlots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    slotId = json['slot_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['schedule_slot_times'] != null) {
      scheduleSlotTimes = <ScheduleSlotTimes>[];
      json['schedule_slot_times'].forEach((v) { scheduleSlotTimes!.add(new ScheduleSlotTimes.fromJson(v)); });
    }
    slot = json['slot'] != null ? new Slot.fromJson(json['slot']) : null;
    createdAgo = json['created_ago'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schedule_id'] = this.scheduleId;
    data['slot_id'] = this.slotId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;

    if (this.slot != null) {
      data['slot'] = this.slot!.toJson();
    }
    if (this.scheduleSlotTimes != null) {
      data['schedule_slot_times'] = this.scheduleSlotTimes!.map((v) => v.toJson()).toList();
    }
    data['created_ago'] = this.createdAgo;
    return data;
  }
}

class Slot {
  int? id;
  int? duration;
  int? amount;
  RxBool? isSelected;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? createdAgo;

  Slot({this.id, this.duration, this.isSelected,this.amount, this.createdAt, this.updatedAt, this.deletedAt, this.createdAgo});

  Slot.fromJson(Map<String, dynamic> json) {
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


class ScheduleSlotTimes {
  String? startTime;
  String? endTime;

  ScheduleSlotTimes({this.startTime, this.endTime});

  ScheduleSlotTimes.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}