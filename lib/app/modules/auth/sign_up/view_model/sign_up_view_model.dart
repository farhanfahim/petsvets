import 'dart:ffi';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mime/mime.dart';
import 'package:petsvet_connect/app/components/resources/app_images.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/file_picker_util.dart';
import '../../../../data/enums/AccountType.dart';
import '../../../../data/enums/PickerType.dart';
import '../../../../data/enums/page_type.dart';
import '../../../../data/models/dummy_model.dart';
import '../../../../data/models/local_location.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../repository/media_upload_repository.dart';
import '../../../../routes/app_pages.dart';
class SignUpViewModel extends GetxController {
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();

  final AuthRepository repository;


  final MediaUploadRepository mediaUploadRepository;

  SignUpViewModel({required this.repository, required this.mediaUploadRepository});

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  TextEditingController nameController = TextEditingController(text: "");
  FocusNode nameNode = FocusNode();
  TextEditingController emailController = TextEditingController(text: "");
  FocusNode emailNode = FocusNode();
  Rx<TextEditingController> phoneController = TextEditingController(text: "").obs;
  FocusNode phoneNode = FocusNode();
  Rx<TextEditingController> altPhoneController = TextEditingController(text: "").obs;
  FocusNode altPhoneNode = FocusNode();
  TextEditingController passwordController = TextEditingController(text: "");
  FocusNode passwordNode = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordNode = FocusNode();
  TextEditingController addressController = TextEditingController(text: "");
  FocusNode addressNode = FocusNode();

  Rx<PhoneNumber> initialPhone = PhoneNumber(isoCode: 'US').obs;
  Rx<PhoneNumber> altInitialPhone = PhoneNumber(isoCode: 'US').obs;
  RxString? phoneNumber = ''.obs;
  RxString? altPhoneNumber = ''.obs;
  RxList<DummyModel> arrOfAccountType = List<DummyModel>.empty().obs;
  Rx<bool> absorb = false.obs;

  Rx<bool> showPassword = true.obs;
  Rx<bool> showConfirmPassword = true.obs;
  Rx<bool> isCheck = false.obs;
  Rx<bool> isSharePetRecords = false.obs;
  Rx<bool> isCheckTerms = false.obs;
  Rx<bool> accessPharmacy = false.obs;
  Rx<bool> noAccessPharmacy = false.obs;

  Rxn<File?> fileImage = Rxn();

  final _firebaseMessaging = FirebaseMessaging.instance;

  var data = Get.arguments;

  AccountType? page;


  Rx<LocalLocation> selectedAddress = LocalLocation().obs;


  @override
  void onInit() {
    super.onInit();
    arrOfAccountType.add(DummyModel(id: "1",image: AppImages.imgPetType,title: "txt_pet_owner".tr,subTitle: "txt_pet_owner_desc".tr,isSelected:false.obs));
    arrOfAccountType.add(DummyModel(id: "2",image: AppImages.imgVetType,title: "txt_veterinarians".tr,subTitle: "txt_veterinarians_desc".tr,isSelected:false.obs));

    if (data != null ) {
      page = data[ArgumentConstants.type];
    }
  }

  void pickImageFromCamera() async {
    final pickedFile = await FilePickerUtil.pickImages(pickerType: PickerType.camera);
    if (pickedFile != null && pickedFile.isNotEmpty) {
      fileImage.value = File(pickedFile.first.path!);
    }
  }

  void pickImageFromGallery() async {
    final pickedFile = await FilePickerUtil.pickImages();
    if (pickedFile != null && pickedFile.isNotEmpty) {
      fileImage.value = File(pickedFile.first.path!);
    }
  }

  void onSignUpTap() {
    if (  formKey.currentState?.validate() == true) {


    } else {
      print('not validated');
    }
    if (  formKey1.currentState?.validate() == true) {

      if(page == AccountType.pet){
        if(accessPharmacy.value || noAccessPharmacy.value){
          if(isCheckTerms.value){

            if(isSharePetRecords.value){

              if(phoneController.value.text != altPhoneController.value.text){

                uploadMediaToBucket();

              }

            }else{
              Util.showToast("Please agree to share pet records ");
            }

          }else{
            Util.showToast("Please agree to our Terms & Conditions ");
          }
        }else{
          Util.showToast("Please select pharmacy access option");
        }
      }else{
        if(isCheckTerms.value){

          uploadMediaToBucket();
          
        }else{
          Util.showToast("Please agree to our Terms & Conditions ");
        }
      }

    } else {
      print('not validated');
    }
  }


  Future<dynamic>  signUpAPI({String? imageUrl}) async {

    var data = {
      'full_name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'platform': (Platform.isIOS) ? 'ios' : 'android',
      "device_type":"mobile",
      'device_token': "abc",
      'phone': phoneNumber!.value,
      'alternate_phone': altPhoneNumber!.value,
      'role_id': page == AccountType.pet?2:3,
      if(page == AccountType.vet)'latitude': selectedAddress.value.coordinates!.first,
      if(page == AccountType.vet)'longitude': selectedAddress.value.coordinates!.last,
      if(page == AccountType.pet)'access_pharmacy': accessPharmacy.value,
      if(page == AccountType.pet)'share_pet_record': isSharePetRecords.value,
      'image_url':imageUrl,
    };

    print(data);
    final result = await repository.userSignUp(data);
    result.fold((l) {

      if(l.message == "The alternate_phone format is invalid"){
        Util.showAlert(title: "The alternate phone format is invalid", error: true);
      }else{
        print(l.message);

        Util.showAlert(title: l.message, error: true);
      }
      absorb.value = false;
      btnController.error();
      btnController.reset();

    }, (response) {
      absorb.value = false;
      btnController.success();
      btnController.reset();

      Get.toNamed(Routes.VERIFY_OTP, arguments: {
        ArgumentConstants.pageType: PageType.signUp,
        ArgumentConstants.email: emailController.text.trim(),
        ArgumentConstants.phone: phoneNumber!.value,
      });


    });

  }


  Future<dynamic>  uploadMediaToBucket() async {
    if (formKey.currentState!.validate()) {
      absorb.value = true;
      btnController.start();
      if(fileImage.value != null) {
        var fileMimeType = lookupMimeType(fileImage.value!.path)!;

        var map = {'contentType': fileMimeType};

        print(map);
        final result = await mediaUploadRepository.getBucketDetailsForFileUpload(map);
        result.fold((l) {

          Util.showAlert(title: l.message, error: true);

        }, (response) async {

          Map<String, dynamic> map = {
            'url': response.data.result!.url,
            'acl': response.data.result!.fields!.aCL,
            'contentType': response.data.result!.fields!.contentType,
            'bucket': response.data.result!.fields!.bucket,
            'algorithm': response.data.result!.fields!.xAmzAlgorithm,
            'credentials': response.data.result!.fields!.xAmzCredential,
            'date': response.data.result!.fields!.xAmzDate,
            'key': response.data.result!.fields!.key,
            'policy': response.data.result!.fields!.policy,
            'signature': response.data.result!.fields!.xAmzSignature,
            'image': fileImage.value!.path,
            'fileName': fileImage.value!.path.split('/').last
          };
          final result = await mediaUploadRepository.uploadFile(map);
          result.fold((l) {
            print(l.message);

          }, (response) async {

            signUpAPI(imageUrl: response);
          });
        });
      }
      else {
        signUpAPI(imageUrl: '');
      }
    }
  }



}
