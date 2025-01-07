import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/add_location_picker/view/add_location_picker_view.dart';
import 'package:petsvet_connect/app/modules/addresses/views/addresses_view.dart';
import 'package:petsvet_connect/app/modules/auth/sign_up/views/sign_up_view.dart';
import 'package:petsvet_connect/app/modules/auth/success/bindings/success_view_binding.dart';
import 'package:petsvet_connect/app/modules/auth/success/views/success_view.dart';
import 'package:petsvet_connect/app/modules/contact_us/bindings/contact_us_binding.dart';
import 'package:petsvet_connect/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:petsvet_connect/app/modules/dashboard/views/dashboard_view.dart';
import 'package:petsvet_connect/app/modules/delete_account/bindings/delete_account_binding.dart';
import 'package:petsvet_connect/app/modules/delete_account/views/delete_account_view.dart';
import 'package:petsvet_connect/app/modules/manage_subscription/bindings/manage_subscription_binding.dart';
import 'package:petsvet_connect/app/modules/manage_subscription/views/manage_subscription_view.dart';
import 'package:petsvet_connect/app/modules/notifications/views/notification_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/add_pet/views/add_pet_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/appointment_history/views/appointment_history_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/edit_profile/views/edit_profile_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/other_vet/views/other_vet_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/vet_profile/views/vet_profile_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/appointment_detail/bindings/appointment_detail_binding.dart';
import 'package:petsvet_connect/app/modules/pet_module/appointment_detail/views/appointment_detail_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/cancel_appointment/views/cancel_appointment_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/medical_record/bindings/medical_record_view_binding.dart';
import 'package:petsvet_connect/app/modules/pet_module/medical_record/views/medical_record_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/views/my_appointment_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/payment_detail/bindings/payment_detail_view_binding.dart';
import 'package:petsvet_connect/app/modules/pet_module/payment_detail/views/payment_detail_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/schedule_appointment/views/schedule_appointment_view.dart';
import 'package:petsvet_connect/app/modules/pet_post_registration/pet_info/views/pet_info_view.dart';
import 'package:petsvet_connect/app/modules/subscription/bindings/subscription_binding.dart';
import 'package:petsvet_connect/app/modules/subscription/views/subscription_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/edit_time_slot/views/edit_time_slot_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/prescribe_medicine/bindings/prescirbe_medicine_binding.dart';
import 'package:petsvet_connect/app/modules/vet_module/prescribe_medicine/views/prescirbe_medicine_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/statistics/bindings/statistics_binding.dart';
import 'package:petsvet_connect/app/modules/vet_module/statistics/views/statistics_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/statistics_detail/bindings/statistics_detail_binding.dart';
import 'package:petsvet_connect/app/modules/vet_module/statistics_detail/views/statistics_detail_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/vet_appointment_detail/bindings/vet_appointment_detail_binding.dart';
import 'package:petsvet_connect/app/modules/vet_module/vet_appointment_detail/views/vet_appointment_detail_view.dart';
import 'package:petsvet_connect/app/modules/vet_module/vet_my_profile/views/vet_my_profile_view.dart';
import 'package:petsvet_connect/app/modules/vet_post_registration/account_setup/bindings/vet_account_setup_view_binding.dart';
import 'package:petsvet_connect/app/modules/vet_post_registration/account_setup/views/vet_account_setup_view.dart';
import 'package:petsvet_connect/app/modules/video_call/bindings/video_call_binding.dart';
import 'package:petsvet_connect/app/modules/video_call/views/video_call_view.dart';
import '../modules/auth/forgot_password/views/forgot_password_view.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/page/views/page_view.dart';
import '../modules/auth/reset_password/views/reset_password_view.dart';
import '../modules/auth/splash/bindings/splash_binding.dart';
import '../modules/auth/splash/views/splash_view.dart';
import '../modules/auth/verify_otp/views/verify_otp_view.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/chat_module/chat/bindings/chat_binding.dart';
import '../modules/chat_module/chat/views/chat_view.dart';
import '../modules/chat_module/chatroom/views/chatroom_view.dart';
import '../modules/chat_module/image_view/image_view.dart';
import '../modules/chat_module/video_view/video_view.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/payment_management/bindings/payment_management_view_binding.dart';
import '../modules/payment_management/views/payment_management_view.dart';
import '../modules/pet_module/vet_search/views/vet_search_view.dart';
import '../modules/pet_module/filter/bindings/filter_binding.dart';
import '../modules/pet_module/filter/views/filter_view.dart';
import '../modules/pet_module/pet_more_info/views/pet_more_info_view.dart';
import '../modules/pet_module/profile/views/profile_view.dart';
import '../modules/pet_post_registration/account_setup/bindings/account_setup_view_binding.dart';
import '../modules/pet_post_registration/account_setup/views/account_setup_view.dart';
import '../modules/pet_post_registration/pet_type/views/pet_type_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/views/setting_view.dart';
import '../modules/vet_module/add_time_slot/views/add_time_slot_view.dart';
import '../modules/vet_module/manage_time_slot/views/manage_time_slot_view.dart';
import '../modules/vet_module/vet_appointment_history/bindings/vet_appointment_history_binding.dart';
import '../modules/vet_module/vet_appointment_history/views/vet_appointment_history_view.dart';
import '../modules/vet_module/vet_edit_profile/views/vet_edit_profile_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      children: [
        GetPage(
          name: _Paths.SPLASH,
          page: () => SplashView(),
          binding: SplashBinding(),
          transition: Transition.native,
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtpView(),
    ),
    GetPage(
      name: _Paths.SUCCESS,
      page: () => SuccessView(),
      binding: SuccessBinding(),
    ),
    GetPage(
      name: _Paths.PAGE,
      page: () => PageView(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETUP,
      page: () => AccountSetupView(),
      binding: AccountSetupViewBinding(),
    ),
    GetPage(
      name: _Paths.PET_TYPE,
      page: () => PetTypeView(),
    ),
    GetPage(
      name: _Paths.PET_INFO,
      page: () => PetInfoView(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.VET_ACCOUNT_SETUP,
      page: () => VetAccountSetupView(),
      binding: VetAccountSetupViewBinding(),
    ),
    GetPage(
      name: _Paths.OTHER_VET,
      page: () => OtherVetView(),
    ),
    GetPage(
      name: _Paths.VET_SEARCH,
      page: () => VetSearchView(),
    ),
    GetPage(
      name: _Paths.VET_PROFILE,
      page: () => VetProfileView(),
    ),
    GetPage(
      name: _Paths.MY_APPOINTMENT,
      page: () => MyAppointmentView(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_DETAIL,
      page: () => AppointmentDetailView(),
      binding: AppointmentDetailBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => FilterView(),
      binding: FilterBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
    ),
    GetPage(
      name: _Paths.DELETE_ACCOUNT,
      page: () => DeleteAccountView(),
      binding: DeleteAccountBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_SUBSCRIPTION,
      page: () => ManageSubscriptionView(),
      binding: ManageSubscriptionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
    ),
    GetPage(
      name: _Paths.SCHEDULE_APPOINTMENT,
      page: () => ScheduleAppointmentView(),
    ),
    GetPage(
      name: _Paths.MEDICAL_RECORD,
      page: () => MedicalRecordView(),
      binding: MedicalRecordViewBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_VIEW,
      page: () => DashboardView(),
      binding: DashboardBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.ADD_PET,
      page: () => AddPetView(),
    ),
    GetPage(
      name: _Paths.PET_MORE_INFO,
      page: () => PetMoreInfoView(),
    ),
    GetPage(
      name: _Paths.ADDRESSES,
      page: () => AddressesView(),
    ),
    GetPage(
      name: _Paths.ADD_LOCATION_PCIKER,
      page: () => AddLocationPickerView(),
    ),
    GetPage(
      name: _Paths.PAYMENT_DETAIL,
      page: () => PaymentDetailView(),
      binding: PaymentDetailBinding(),
    ),
    GetPage(
      name: _Paths.CANCEL_APPOINTMENT,
      page: () => CancelAppointmentView(),
    ),
    GetPage(
      name: _Paths.VET_APPOINTMENT_DETAIL,
      page: () => VetAppointmentDetailView(),
      binding: VetAppointmentDetailBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => ChatRoomView(),
    ),
    GetPage(
      name: _Paths.IMAGE_VIEW,
      page: () => ImageView(),
    ),
    GetPage(
      name: _Paths.VIDEO_VIEW,
      page: () => VideoView(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_HISTORY,
      page: () => AppointmentHistoryView(),
    ),
    GetPage(
      name: _Paths.VET_APPOINTMENT_HISTORY,
      page: () => VetAppointmentHistoryView(),
      binding: VetAppointmentHistoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
    ),
    GetPage(
      name: _Paths.MANAGE_TIME_SLOT,
      page: () => ManageTimeSlotView(),
    ),
    GetPage(
      name: _Paths.ADD_TIME_SLOT,
      page: () => AddTimeSlotView(),
    ),
    GetPage(
      name: _Paths.VET_MY_PROFILE,
      page: () => VetMyProfileView(),
    ),
    GetPage(
      name: _Paths.VET_EDIT_PROFILE,
      page: () => VetEditProfileView(),
    ),
    GetPage(
      name: _Paths.STATISTICS,
      page: () => StatisticsView(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: _Paths.STATISTIC_DETAIL,
      page: () => StatisticsDetailView(),
      binding: StatisticsDetailBinding(),
    ),
    GetPage(
      name: _Paths.PRESCRIBE_MEDICINE,
      page: () => PrescribeMedicineView(),
      binding: PrescribeMedicineBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_MANAGEMENT,
      page: () => PaymentManagementView(),
      binding: PaymentManagementBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_SLOT,
      page: () => EditTimeSlotView(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),

  ];
}
