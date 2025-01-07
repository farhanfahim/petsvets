import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petsvet_connect/app/data/enums/AccountType.dart';
import 'package:petsvet_connect/app/data/enums/status_type.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';

class DummyAppointmentModel {
  String? image;
  String? name;
  dynamic type;
  String? timings;

  DummyAppointmentModel({
    this.image,
    this.name,
    this.type,
    this.timings,
  });

}

