import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mime/mime.dart';
import 'package:petsvet_connect/utils/date_time_util.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../../shared_prefrences/app_prefrences.dart';
import '../../../../../utils/Util.dart';
import 'package:http/http.dart' as http;
import 'package:phone_number/phone_number.dart' as PhoneNumberValidator;
import '../../../../../utils/constants.dart';
import '../../../../../utils/file_picker_util.dart';
import '../../../../data/enums/PickerType.dart';
import '../../../../data/models/add_vet_model.dart';
import '../../../../data/models/dummy_model.dart';
import '../../../../data/models/pet_type_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../firestore/firestore_controller.dart';
import '../../../../repository/media_upload_repository.dart';
import '../../../../repository/vet_edit_profile_repository.dart';
import '../../../my_profile/view_model/my_profile_view_model.dart';
import '../../vet_my_profile/view_model/vet_my_profile_view_model.dart';
class VetEditProfileViewModel extends GetxController {

  final VetEditProfileRepository repository;
  final MediaUploadRepository mediaUploadRepository;

  VetEditProfileViewModel({required this.repository, required this.mediaUploadRepository});

  Rx<UserModel> userModel = UserModel().obs;

  var formKey = GlobalKey<FormState>();

  var formKey1 = GlobalKey<FormState>();
  final ScrollController scrollController=ScrollController();
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  Rx<TextEditingController> phoneController = TextEditingController(text: "").obs;
  Rx<TextEditingController> altPhoneController = TextEditingController(text: "").obs;
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController deaNumberController = TextEditingController(text: "");
  TextEditingController doctorTypeController = TextEditingController(text: "");
  TextEditingController stateControlController = TextEditingController(text: "");
  TextEditingController specializationController = TextEditingController(text: "");
  TextEditingController aboutController = TextEditingController(text: "");
  TextEditingController startTimeController = TextEditingController(text: "");
  TextEditingController endTimeController = TextEditingController(text: "");

  FocusNode addressNode = FocusNode();
  FocusNode deaNumberNode = FocusNode();
  FocusNode stateControlNode = FocusNode();
  FocusNode doctorTypeNode = FocusNode();
  FocusNode specializationNode = FocusNode();
  FocusNode aboutNode = FocusNode();
  FocusNode altPhoneNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode startTimeNode = FocusNode();
  FocusNode endTimeNode = FocusNode();


  DateTime? startSelectedTime;
  DateTime? endSelectedTime;

  RxList<PetTypeModel> arrOfState = List<PetTypeModel>.empty().obs;
  RxList<PetTypeModel> arrOfSpecialization = List<PetTypeModel>.empty().obs;
  RxList<PetTypeModel> arrOfDoctorType = List<PetTypeModel>.empty().obs;



  Rx<PhoneNumber> initialPhone = PhoneNumber(isoCode: 'US').obs;
  Rx<PhoneNumber> altInitialPhone = PhoneNumber(isoCode: 'US').obs;
  RxString? phoneNumber = ''.obs;
  RxDouble? lat = 0.0.obs;
  RxDouble? lng = 0.0.obs;
  RxString? altPhoneNumber = ''.obs;
  RxList<DummyModel> arrOfAccountType = List<DummyModel>.empty().obs;
  Rx<bool> absorb = false.obs;

  RxString? userImage = ''.obs;
  Rxn<File?> fileImage = Rxn<File>();

  final MyProfileViewModel profileViewModel = Get.find();
  final VetMyProfileViewModel myProfileViewModel = Get.find();
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  RxList<VetSpecializations> arrSelectedOfSpecialization = List<VetSpecializations>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    generateState();
    generateSpecialization();
    generateDoctorType();
    AppPreferences.getUserDetails().then((value) {
      userModel.value = value!;
      nameController.text = userModel.value.user!.fullName!;
      emailController.text = userModel.value.user!.email!;
      lat!.value = userModel.value.user!.latitude!;
      lng!.value = userModel.value.user!.longitude!;
      getAddressFromLatLng(Get.context, userModel.value.user!.latitude!, userModel.value.user!.longitude!).then((value) {
        addressController.text = value;
      });
      getPhoneNumber(userModel.value.user!.phone!);
      if(userModel.value.user!.alternatePhone!=null) {
        getAltPhoneNumber(userModel.value.user!.alternatePhone!);
      }
      if(userModel.value.user!.userImage!=null) {
        userImage!.value = userModel.value.user!.userImage!.mediaUrl ?? '';
      }

      deaNumberController.text = userModel.value.user!.userDetail!=null?userModel.value.user!.userDetail!.deaNumber!:"";
      doctorTypeController.text = userModel.value.user!.userDetail!=null?userModel.value.user!.userDetail!.vetType==10?"Doctor of Veterinary Medicine":"Licensed Veterinary Technician":"";
      if(userModel.value.user!.userDetail!=null){
        if(userModel.value.user!.userDetail!.vetType! == 10){
          arrOfDoctorType[0].isSelected!.value = true;
        }else{
          arrOfDoctorType[1].isSelected!.value = true;
        }
      }


      startSelectedTime = DateTimeUtil.stringToDate(userModel.value.user!.userDetail!.startTime,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11);
      endSelectedTime = DateTimeUtil.stringToDate(userModel.value.user!.userDetail!.endTime,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11);
      startTimeController.text = DateTimeUtil.formatDateTime(startSelectedTime!, outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
      endTimeController.text = DateTimeUtil.formatDateTime(endSelectedTime!, outputDateTimeFormat: DateTimeUtil.dateTimeFormat9);
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


  Future<String> getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${Constants.mapApiKey}&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else return "";
    } else return "";
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
  generateDoctorType(){
    arrOfDoctorType.add(PetTypeModel(title: "doctor_veterinary_medicine".tr,breed:"".obs,isSelected:false.obs));
    arrOfDoctorType.add(PetTypeModel(title: "doctor_veterinary_technician".tr,breed:"".obs,isSelected:false.obs));
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


    } else {
      print('not validated');
    }
    if (  formKey1.currentState?.validate() == true) {

      uploadMediaToBucket();


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
        'latitude': lat!.value,
        'longitude': lng!.value,
        'dea_number': deaNumberController.text,
        //'vet_specializations': altPhoneNumber!.value,
        'start_time': DateTimeUtil.formatDate(startTimeController.text,inputDateTimeFormat:DateTimeUtil.dateTimeFormat9,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
        'end_time': DateTimeUtil.formatDate(endTimeController.text,inputDateTimeFormat:DateTimeUtil.dateTimeFormat9,outputDateTimeFormat: DateTimeUtil.dateTimeFormat11),
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
        userModel.value.user!.userDetail!.deaNumber = response.data.userDetail!.deaNumber;
        userModel.value.user!.userDetail!.vetType = response.data.userDetail!.vetType;
        userModel.value.user!.userDetail!.startTime = response.data.userDetail!.startTime;
        userModel.value.user!.userDetail!.endTime = response.data.userDetail!.endTime;

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
        profileViewModel.userModel.value.user!.userDetail!.deaNumber = response.data.userDetail!.deaNumber;
        profileViewModel.userModel.value.user!.userDetail!.vetType = response.data.userDetail!.vetType;
        profileViewModel.userModel.value.user!.userDetail!.startTime = response.data.userDetail!.startTime;
        profileViewModel.userModel.value.user!.userDetail!.endTime = response.data.userDetail!.endTime;

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
        myProfileViewModel.userModel.value.user!.userDetail!.deaNumber = response.data.userDetail!.deaNumber;
        myProfileViewModel.userModel.value.user!.userDetail!.vetType = response.data.userDetail!.vetType;
        myProfileViewModel.userModel.value.user!.userDetail!.startTime = response.data.userDetail!.startTime;
        myProfileViewModel.userModel.value.user!.userDetail!.endTime = response.data.userDetail!.endTime;
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
