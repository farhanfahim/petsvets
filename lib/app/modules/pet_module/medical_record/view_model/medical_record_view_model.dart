import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/image_type.dart';
import 'package:petsvet_connect/app/data/models/Attachments.dart';

import 'package:path/path.dart' as path;
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../data/models/user_model.dart';



class MedicalRecordViewModel extends GetxController {

  RxList<Attachments> arrOfImage = List<Attachments>.empty().obs;

  Rx<UserModel> userModel = UserModel().obs;

  var data = Get.arguments;

  @override
  void onInit() {
    super.onInit();

    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;

      /*for(var item in userModel.value.user!.medicalRecords!){
        arrOfImage.add(Attachments(
          url: item.mediumImage,
          name: path.basename(item.path!)
            ,isNetwork: true
        ));
      }*/
      arrOfImage.refresh();
    });

  }


}
