import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../utils/Util.dart';
import '../../../../data/models/Attachments.dart';
import '../../../../data/models/add_vet_model.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../account_setup/view_model/vet_account_setup_view_model.dart';

class GeneralInfoViewModel extends GetxController {

  GeneralInfoViewModel();

  var formKey = GlobalKey<FormState>();
  Rx<bool> absorb = false.obs;
  final VetAccountSetupViewModel accountSetupViewModel = Get.find();

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  final ScrollController scrollController=ScrollController();
  TextEditingController stateLicenseController = TextEditingController(text: "");
  TextEditingController stateController = TextEditingController(text: "");
  TextEditingController stateNationalController = TextEditingController(text: "");
  TextEditingController deaNumberController = TextEditingController(text: "");
  TextEditingController stateControlController = TextEditingController(text: "");
  TextEditingController specializationController = TextEditingController(text: "");
  TextEditingController aboutController = TextEditingController(text: "");
  FocusNode stateLicenseNode = FocusNode();
  FocusNode stateNode = FocusNode();
  FocusNode stateNationalNode = FocusNode();
  FocusNode deaNumberNode = FocusNode();
  FocusNode stateControlNode = FocusNode();
  FocusNode specializationNode = FocusNode();
  FocusNode aboutNode = FocusNode();


  RxList<PetTypeModel> arrOfState = List<PetTypeModel>.empty().obs;
  RxList<PetTypeModel> arrOfSpecialization = List<PetTypeModel>.empty().obs;
  RxList<VetSpecializations> arrSelectedOfSpecialization = List<VetSpecializations>.empty().obs;

  Rx<bool> veterinaryTechnician = false.obs;
  Rx<bool> veterinaryMedicine = true.obs;

  RxList<Attachments> arrOfImage = List<Attachments>.empty().obs;
  RxList<LicenseDocuments> arrOfSelectedImages = List<LicenseDocuments>.empty().obs;



  @override
  void onInit() {
    super.onInit();
    generateState();
    generateSpecialization();
  }


  generateState(){
    arrOfState.add(PetTypeModel(title: "",breed:"California".obs,isSelected:false.obs));
    arrOfState.add(PetTypeModel(title: "",breed:"New York".obs,isSelected:false.obs));
    arrOfState.add(PetTypeModel(title: "",breed:"Texas".obs,isSelected:false.obs));
    arrOfState.add(PetTypeModel(title: "",breed:"Florida".obs,isSelected:false.obs));
    arrOfState.add(PetTypeModel(title: "",breed:"Illinois".obs,isSelected:false.obs));
    arrOfState.add(PetTypeModel(title: "",breed:"Pennsylvania".obs,isSelected:false.obs));
  }

  generateSpecialization(){
    arrOfSpecialization.add(PetTypeModel(title: "Large Animal",breed:"".obs,isSelected:false.obs));
    arrOfSpecialization.add(PetTypeModel(title: "Small Animal",breed:"".obs,isSelected:false.obs));
    arrOfSpecialization.add(PetTypeModel(title: "Exotic Animals and Birds",breed:"".obs,isSelected:false.obs));
  }



  onTapNext(){
    if (arrOfImage.isEmpty) {
      Util.showToast("Please upload document");
    }
     if (formKey.currentState?.validate() == true) {
       if (arrOfImage.isNotEmpty) {
         Util.hideKeyBoard(Get.context!);
         arrSelectedOfSpecialization.value = [];
         for(var item in arrOfSpecialization){
           if(item.isSelected!.isTrue) {
             if(item.title == "Large Animal"){
               arrSelectedOfSpecialization.add(VetSpecializations(petType: 10));//10 Large Animal
             }
             if(item.title == "Small Animal"){
               arrSelectedOfSpecialization.add(VetSpecializations(petType: 20));//10 Small Animal
             }
             if(item.title == "Exotic Animals and Birds"){
               arrSelectedOfSpecialization.add(VetSpecializations(petType: 30));//30 Exotic Animals and Birds
             }
           }
         }
         arrOfSelectedImages.value = [];
         for(var item in arrOfImage){
           arrOfSelectedImages.add(LicenseDocuments(path: item.url!,type: item.imageType.name));
         }

         accountSetupViewModel.changePage(1);

       } else {
        Util.showToast("Please upload document");
       }
    } else {
      print('not validated');
    }
  }


}
