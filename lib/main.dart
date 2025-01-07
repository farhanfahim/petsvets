import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:petsvet_connect/app/repository/change_password_repository.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/shared_prefrences/app_prefrences.dart';
import 'app/repository/add_pet_repository.dart';
import 'app/repository/address_repository.dart';
import 'app/repository/auth_repository.dart';
import 'app/repository/cancel_appointment_repository.dart';
import 'app/repository/notification_repository.dart';
import 'app/repository/pet_appointment_repository.dart';
import 'app/repository/pet_edit_profile_repository.dart';
import 'app/repository/pet_home_repository.dart';
import 'app/repository/pet_post_registration_repository.dart';
import 'app/repository/pet_profile_repository.dart';
import 'app/repository/schedule_repository.dart';
import 'app/repository/search_repository.dart';
import 'app/repository/setting_repository.dart';
import 'app/repository/slot_repository.dart';
import 'app/repository/vet_edit_profile_repository.dart';
import 'app/repository/vet_home_repository.dart';
import 'app/repository/vet_post_registration_repository.dart';
import 'app/repository/vet_profile_repository.dart';
import 'app/repository_imp/Schedule_repository_impl.dart';
import 'app/repository_imp/add_pet_repository_impl.dart';
import 'app/repository_imp/address_repository_impl.dart';
import 'app/repository_imp/auth_repository_imp.dart';
import 'app/repository_imp/cancel_appointment_repository_impl.dart';
import 'app/repository_imp/change_password_repository_impl.dart';
import 'app/repository_imp/notification_repository_impl.dart';
import 'app/repository_imp/pet_appointment_repository_impl.dart';
import 'app/repository_imp/pet_edit_profile_repository_impl.dart';
import 'app/repository_imp/pet_home_repository_impl.dart';
import 'app/repository_imp/pet_post_registration_repository_impl.dart';
import 'app/repository_imp/pet_profile_repository_impl.dart';
import 'app/repository_imp/search_repository_impl.dart';
import 'app/repository_imp/setting_repository_impl.dart';
import 'app/repository_imp/slot_repository_impl.dart';
import 'app/repository_imp/vet_edit_profile_repository_impl.dart';
import 'app/repository_imp/vet_home_repository_impl.dart';
import 'app/repository_imp/vet_post_registration_repository_impl.dart';
import 'app/repository_imp/vet_profile_repository_impl.dart';
import 'app/routes/app_pages.dart';
import 'config/translations/localization_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initAllRepositories();
  if(Platform.isAndroid) {
    await Firebase.initializeApp(
       options: const FirebaseOptions(
      apiKey: "AIzaSyAr_46cnw6qSDvbYF07qHyxkSMhfqvv9q8", // paste your api key here
      appId: "1:615159498494:android:b414200149cc9b044ac7af", //paste your app id here
      messagingSenderId: "615159498494", //paste your messagingSenderId here
      projectId: "petsvet-76539", //paste your project id here
    ),
    );
  }else{
    await Firebase.initializeApp();
  }

  ///Initialize SharedPreference here
  await AppPreferences.init();

  runApp(const MyApp());
}


void initAllRepositories() {
  var authRepo = Get.put<AuthRepository>(AuthRepositoryImpl());
  var changePasswordRepo = Get.put<ChangePasswordRepository>(ChangePasswordRepositoryImpl());
  var settingRepo = Get.put<SettingRepository>(SettingRepositoryImpl());
  var petPostRegistrationRepo = Get.put<PetPostRegistrationRepository>(PetPostRegistrationRepositoryImpl());
  var vetPostRegistrationRepo = Get.put<VetPostRegistrationRepository>(VetPostRegistrationRepositoryImpl());
  var petEditProfileRepo = Get.put<PetEditProfileRepository>(PetEditProfileRepositoryImpl());
  var petProfileRepo = Get.put<PetProfileRepository>(PetProfileRepositoryImpl());
  var addressRepo = Get.put<AddressRepository>(AddressRepositoryImpl());
  var addPetRepo = Get.put<AddPetRepository>(AddPetRepositoryImpl());
  var petHomeRepo = Get.put<PetHomeRepository>(PetHomeRepositoryImpl());
  var searchRepo = Get.put<SearchRepository>(SearchRepositoryImpl());
  var vetRepo = Get.put<VetProfileRepository>(VetProfileRepositoryImpl());
  var vetEditRepo = Get.put<VetEditProfileRepository>(VetEditProfileRepositoryImpl());
  var slotRepo = Get.put<SlotRepository>(SlotRepositoryImpl());
  var vetHomeRepo = Get.put<VetHomeRepository>(VetHomeRepositoryImpl());
  var petAppointmentRepo = Get.put<PetAppointmentRepository>(PetAppointmentRepositoryImpl());
  var notificationRepo = Get.put<NotificationRepository>(NotificationRepositoryImpl());
  var scheduleRepo = Get.put<ScheduleRepository>(ScheduleRepositoryImpl());
  var cancelAppointmentRepo = Get.put<CancelAppointmentRepository>(CancelAppointmentRepositoryImpl());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return OverlaySupport(
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(
            builder: (context,child){
              return MediaQuery(
                  data:MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child:child!,
              );
            },
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.standard,
              dividerTheme: const DividerThemeData(
                color: AppColors.gray600,
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            ),
            translations: LocalizationService(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            title: 'Pets Vet Connect',
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        },
      ),
    );
  }
}
