import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class DummyVetsModel {
  String? image;
  String? name;
  String? skill;
  String? location;
  LatLng? latLng;
  bool? isOpen;
  String? timings;
  RxBool? isSelected;

  DummyVetsModel({
    this.image,
    this.name,
    this.skill,
    this.location,
    this.latLng,
    this.isOpen,
    this.timings,
    this.isSelected,
  });

}

