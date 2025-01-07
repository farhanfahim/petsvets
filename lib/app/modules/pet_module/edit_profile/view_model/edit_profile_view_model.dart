import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mime/mime.dart';
import 'package:phone_number/phone_number.dart' as PhoneNumberValidator;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../../utils/Util.dart';
import '../../../../../utils/file_picker_util.dart';
import '../../../../data/enums/AccountType.dart';
import '../../../../data/enums/PickerType.dart';
import '../../../../data/models/dummy_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../firestore/firestore_controller.dart';
import '../../../../repository/media_upload_repository.dart';
import '../../../../repository/pet_edit_profile_repository.dart';
import '../../../my_profile/view_model/my_profile_view_model.dart';
import '../../profile/view_model/profile_view_model.dart';
class EditProfileViewModel extends GetxController {

  final PetEditProfileRepository repository;
  final MediaUploadRepository mediaUploadRepository;

  EditProfileViewModel({required this.repository, required this.mediaUploadRepository});


  Rx<UserModel> userModel = UserModel().obs;
  var formKey = GlobalKey<FormState>();

  final ScrollController scrollController=ScrollController();
  TextEditingController nameController = TextEditingController(text: "");
  FocusNode nameNode = FocusNode();
  TextEditingController emailController = TextEditingController(text: "");
  FocusNode emailNode = FocusNode();
  Rx<TextEditingController> phoneController = TextEditingController(text: "").obs;
  FocusNode phoneNode = FocusNode();
  Rx<TextEditingController> altPhoneController = TextEditingController(text: "").obs;
  FocusNode altPhoneNode = FocusNode();

  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  Rx<PhoneNumber> initialPhone = PhoneNumber(isoCode: 'US').obs;
  Rx<PhoneNumber> altInitialPhone = PhoneNumber(isoCode: 'US').obs;
  RxString? phoneNumber = ''.obs;
  RxString? altPhoneNumber = ''.obs;
  RxList<DummyModel> arrOfAccountType = List<DummyModel>.empty().obs;
  Rx<bool> absorb = false.obs;

  final ProfileViewModel profileViewModel = Get.find();
  final MyProfileViewModel myProfileViewModel = Get.find();
  Rx<bool> isCheck = false.obs;
  Rx<bool> accessPharmacy = false.obs;
  Rx<bool> noAccessPharmacy = false.obs;
  RxString? userImage = ''.obs;
  Rxn<File?> fileImage = Rxn<File>();

  var data = Get.arguments;

  AccountType? page;


  @override
  void onInit() {
    super.onInit();
    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      nameController.text = userModel.value.user!.fullName!;
      emailController.text = userModel.value.user!.email!;
      getPhoneNumber(userModel.value.user!.phone!);
      if(userModel.value.user!.alternatePhone!=null) {
        getAltPhoneNumber(userModel.value.user!.alternatePhone!);
      }
      if(userModel.value.user!.userImage!=null) {
        userImage!.value = userModel.value.user!.userImage!.mediaUrl ?? '';
      }
      accessPharmacy.value = userModel.value.user!.accessPharmacy==1?true:false;
      noAccessPharmacy.value = userModel.value.user!.accessPharmacy==0?true:false;
    });
  }

  void getPhoneNumber(String mobileNumber) async {



    try {


      PhoneNumberValidator.PhoneNumber validatedPhoneNumber =
      await PhoneNumberValidator.PhoneNumberUtil()
          .parse(mobileNumber);
      var phoneNumber = PhoneNumber(
          phoneNumber: validatedPhoneNumber.nationalNumber,
          dialCode: validatedPhoneNumber.countryCode,
          isoCode: validatedPhoneNumber.regionCode);
      print("${phoneNumber.phoneNumber}");
      print("${phoneNumber.dialCode}");
      print("${phoneNumber.isoCode}");

      PhoneNumber number =
      await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber.phoneNumber.toString(),phoneNumber.isoCode.toString());

      initialPhone.value = number;


    } catch(e) {
      print("This phone number is not a valid number $e");
    }
  }

  void getAltPhoneNumber(String mobileNumber) async {

    try {

      PhoneNumberValidator.PhoneNumber validatedPhoneNumber =
      await PhoneNumberValidator.PhoneNumberUtil()
          .parse(mobileNumber);
      var phoneNumber = PhoneNumber(
          phoneNumber: validatedPhoneNumber.nationalNumber,
          dialCode: validatedPhoneNumber.countryCode,
          isoCode: validatedPhoneNumber.regionCode);
      print("${phoneNumber.phoneNumber}");
      print("${phoneNumber.dialCode}");
      print("${phoneNumber.isoCode}");

      PhoneNumber number =
      await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber.phoneNumber.toString(),phoneNumber.isoCode.toString());

      altInitialPhone.value = number;


    } catch(e) {
      print("This phone number is not a valid number $e");
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

  void onSave() {
    if (  formKey.currentState?.validate() == true) {
      if(accessPharmacy.value || noAccessPharmacy.value){
        uploadMediaToBucket();
      }else{
        Util.showToast("Please select pharmacy access option");
      }

    } else {
      print('not validated');
    }
  }

  Future<dynamic> onUpdateProfile({String? imageUrl}) async {
    if (formKey.currentState?.validate() == true) {


      var data = {
        'full_name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneNumber!.value,
        'alternate_phone': altPhoneNumber!.value,
        'access_pharmacy': accessPharmacy.value,
        if(imageUrl!.isNotEmpty)'image_url': imageUrl,
      };
      log(jsonEncode(data));
      final result = await repository.updateProfile(data);
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
        log(jsonEncode(response.data));
        btnController.success();
        btnController.reset();
        FirestoreController.instance.updateUserData(response.data);
        userModel.value.user!.fullName = response.data.fullName;
        userModel.value.user!.phone = response.data.phone;
        userModel.value.user!.alternatePhone = response.data.alternatePhone;
        userModel.value.user!.accessPharmacy = response.data.accessPharmacy;

        if(imageUrl.isNotEmpty){
          if(userModel.value.user!.userImage == null){
            userModel.value.user!.userImage = UserImage(mediaUrl: imageUrl);
          }else{
            userModel.value.user!.userImage!.mediaUrl = imageUrl;
          }
        }

        profileViewModel.userModel.value.user!.fullName = response.data.fullName;
        profileViewModel.userModel.value.user!.phone = response.data.phone;
        profileViewModel.userModel.value.user!.alternatePhone = response.data.alternatePhone;
        profileViewModel.userModel.value.user!.accessPharmacy = response.data.accessPharmacy;

        if(imageUrl.isNotEmpty){
          if(profileViewModel.userModel.value.user!.userImage ==null){
            profileViewModel.userModel.value.user!.userImage = UserImage(mediaUrl: imageUrl);
          }else{
            profileViewModel.userModel.value.user!.userImage!.mediaUrl = imageUrl;
          }
        }

        myProfileViewModel.userModel.value.user!.fullName = response.data.fullName;
        myProfileViewModel.userModel.value.user!.phone = response.data.phone;
        myProfileViewModel.userModel.value.user!.alternatePhone = response.data.alternatePhone;
        myProfileViewModel.userModel.value.user!.accessPharmacy = response.data.accessPharmacy;
         if(imageUrl.isNotEmpty){
          if(myProfileViewModel.userModel.value.user!.userImage ==null){
            myProfileViewModel.userModel.value.user!.userImage = UserImage(mediaUrl: imageUrl);
          }else{
            myProfileViewModel.userModel.value.user!.userImage!.mediaUrl = imageUrl;
          }
        }
        AppPreferences.setUserDetails(user: userModel.value);
        myProfileViewModel.userModel.refresh();
        profileViewModel.userModel.refresh();

        Get.back();
        Util.showAlert(title: "changes_has_been_saved");
      });
    } else {
      print('not validated');
    }
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

            onUpdateProfile(imageUrl: response);
          });
        });
      }
      else {
        onUpdateProfile(imageUrl: '');
      }
    }
  }
}
