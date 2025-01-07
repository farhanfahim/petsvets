import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountDialogController extends GetxController {
  final TextEditingController fieldController = TextEditingController();
  FocusNode fieldFocus = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();
}
