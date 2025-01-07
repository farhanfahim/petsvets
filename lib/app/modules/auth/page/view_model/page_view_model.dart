import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/page_type.dart';
import 'package:petsvet_connect/utils/argument_constants.dart';
import '../../../../data/models/page_model.dart';
import '../../../../repository/auth_repository.dart';

class PageViewModel extends GetxController {
  var data = Get.arguments;

  final AuthRepository repository;
  PageViewModel({required this.repository});
  PageType pageType = PageType.terms;
  String content = "";

  Rx<PageModel> pageModel = PageModel().obs;
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (data != null && data[ArgumentConstants.pageType] != null) {
      pageType = data[ArgumentConstants.pageType];
    }

    getPage();
  }

  String getPageTitle() {
    if(pageType == PageType.terms){
      return "lbl_terms_conditions".tr;
    }
    else if(pageType == PageType.privacy){
      return "lbl_privacy_policy".tr;
    }else{
      return "";
    }
  }


  Future<dynamic>  getPage() async {

    isDataLoading.value =  true;

    var map = {
      'slug': (pageType == PageType.terms) ? 'terms-and-condition' : 'privacy-policy',
    };

    final result = await repository.getPage(map);
    result.fold((l) {

      print(l.message);
      isDataLoading.value = false;
      isError.value = true;
      errorMessage.value = l.message;

    }, (response) {
      pageModel.value = response.data;
      isDataLoading.value = false;

    });
  }
}
