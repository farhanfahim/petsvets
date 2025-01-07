import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:petsvet_connect/app/data/models/user_model.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/config/translations/localization_service.dart';
import 'package:petsvet_connect/shared_prefrences/app_prefrences.dart';
import '../../../../../utils/constants.dart';

class SplashViewModel extends GetxController {
  Rxn<PackageInfo> packageInfo = Rxn();

  @override
  Future<void> onInit() async {
    super.onInit();

    await _initPackageInfo();

    _setSelectedLanguage();

    await Future.delayed(3000.milliseconds);
    _nextPage();
  }

  Future<void> _initPackageInfo() async {
    packageInfo.value = await PackageInfo.fromPlatform();
  }

  void _nextPage() async {
    UserModel? model = await AppPreferences.getUserDetails();
    String token = await AppPreferences.getAccessToken();
    if (model!=null) {
      if (token.isNotEmpty) {
        if(model.user!.isCompleted == 1) {
          Get.offAllNamed(Routes.DASHBOARD_VIEW);
        }else{
          if(model.user!.roles!.first.id == 2){
            AppPreferences.setRole(role: Constants.rolePet);
            Get.offAllNamed(Routes.ACCOUNT_SETUP);
          }
          else if(model.user!.roles!.first.id == 3){
            AppPreferences.setRole(role: Constants.roleVet);
            Get.offAllNamed(Routes.VET_ACCOUNT_SETUP);
          }
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void _setSelectedLanguage() async {
    var currentLanguage = AppPreferences.getCurrentLanguage();
    LocalizationService.updateLanguage(currentLanguage);
  }
}
