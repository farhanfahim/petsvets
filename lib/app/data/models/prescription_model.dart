import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/models/Attachments.dart';
import 'package:petsvet_connect/app/data/models/pet_type_model.dart';

class PrescriptionModel {
  var key;
  TextEditingController? medicineName;
  FocusNode? medicineNode;
  TextEditingController? instruction;
  FocusNode? instructionNode;
  TextEditingController? frequency;
  FocusNode? frequencyNode;
  TextEditingController? timings;
  FocusNode? timingsNode;
  TextEditingController? specialInstruction;
  FocusNode? specialInstructionNode;
  RxList<Attachments>? images;
  RxList<PetTypeModel>? arrOfFrequency;
  RxList<PetTypeModel>? arrOfTimings;

  PrescriptionModel({
    this.key,
    this.medicineName,
    this.medicineNode,
    this.instruction,
    this.instructionNode,
    this.frequency,
    this.frequencyNode,
    this.timings,
    this.timingsNode,
    this.specialInstruction,
    this.specialInstructionNode,
    this.images,
    this.arrOfFrequency,
    this.arrOfTimings,
  });

}

