
import 'env/env.dart';

class ApiConstants {
  ///Base url
  static String authBaseUrl = Env.currentEnv.baseUrl ?? "";
  static String baseUrl = Env.currentEnv.baseUrl ?? "";
  static String notificationBaseUrl = Env.currentEnv.notificationUrl ?? "";
  static String storageBaseUrl = Env.currentEnv.storageUrl ?? "";

  ///End points

  ///Storage
  static String fileUpload = '$storageBaseUrl/file/upload';
  static String preSignedUrl = '$storageBaseUrl/files';

  ///Auth
  static String myProfile = '$authBaseUrl/get-profile';
  static String login = '$authBaseUrl/login?relations[]=user_image&relations[]=user_detail&relations[]=medical_records';
  static String register = '$authBaseUrl/register';
  static String verifyOtp = '$authBaseUrl/verify-otp';
  static String resendOtp = '$authBaseUrl/resend-otp';
  static String socialLogin = '$authBaseUrl/social-login';
  static String forgotPassword = '$authBaseUrl/forgot-password';
  static String resetPassword = '$authBaseUrl/reset-password';
  static String changePassword = '$authBaseUrl/change-password';
  static String getProfile = '$authBaseUrl/get-profile';
  static String updatedProfile = '$authBaseUrl/update-profile';
  static String logout = '$authBaseUrl/logout';
  static String updatePassword = '$authBaseUrl/update-password';
  static String deleteAccount = '$authBaseUrl/delete-user';
  static String videos = '$baseUrl/videos/';
  static String donation = '$baseUrl/donation/';
  static String card = '$baseUrl/card/';

  ///Pet/Vet Post Registration
  static String pet = '$baseUrl/pets';
  static String breeds = '$baseUrl/breeds';
  static String userPet = '$baseUrl/user-pets';
  static String addPet = '$baseUrl/add-user-pets';
  static String addVet = '$baseUrl/user-details';

  ///Notifications
  static String notifications = '$baseUrl/notifications';
  static String notificationsRead = '$baseUrl/mark-all-read';

  ///Appointments
  static String appointments = '$baseUrl/appointments';
  static String cancelAppointments = '$baseUrl/update-appointment-status';

  ///Slots
  static String slots = '$baseUrl/slots';
  static String scheduleSlots = '$baseUrl/schedule-slots';
  static String getScheduleSlots = '$baseUrl/get-schedule-by-date';

  ///Settings
  static String toggleNotification = '$baseUrl/notification-toggle';
  static String pages = '$baseUrl/pages?slug=';
  static const terms = 'terms_and_conditions';
  static const privacy = 'privacy_policy';
  static const aboutUs = 'about_us';
  static String faqs = '$baseUrl/faqs/';
  static String contactUs = '$baseUrl/contact-us';
  static String address = '$baseUrl/user-addresses';
  static String updateAddress = '$baseUrl/change-address-default';

  ///Leaves
  static String leaves = '$baseUrl/leaves/';

  ///Lectures/Schedules
  static String schedules = '$baseUrl/schedules/';
  static String scheduleStart = '$baseUrl/schedules/start/';
  static String scheduleEnd = '$baseUrl/schedules/end/';
  static String scheduleDates = '$baseUrl/schedules/listing/month/';
  static String attendances = '$baseUrl/attendances/';
  static String topics = '$baseUrl/topics/';

  static const androidType = 'ANDROID';
  static const iOSType = 'IOS';

  static const notificationToken = 't8HI20P1nAMlgifMBT1S5QK4';


  ///Pet/Home
  static String getVets = '$baseUrl/get-vets';
  static String getVetDetails = '$baseUrl/vet-detail';

  ///Request param keys
  static const accessCode = 'accessCode';
  static const emiratesId = 'emiratesId';
  static const email = 'email';
  static const password = 'password';
  static const oldPassword = 'oldPassword';
  static const newPassword = 'newPassword';
  static const otp = 'otp';
  static const forgotPasswordToken = 'forgotPasswordToken';
  static const certificates = 'certificates';
  static const name = 'name';
  static const message = 'message';
  static const attachment = 'attachment';
  static const page = 'page';
  static const profileImage = 'profileImage';
  static const pushNotification = 'pushNotification';
  static const personalInfoRequest = 'personalInfoRequest';
  static const type = 'type';
  static const startDate = 'startDate';
  static const endDate = 'endDate';
  static const date = 'date';
  static const month = 'month';
  static const year = 'year';
  static const reason = 'reason';
  static const status = 'status';
  static const scheduleId = 'scheduleId';
  static const userIds = 'userIds';
  static const userId = 'user_id';
  static const topicId = 'topicId';
  static const language = 'language';

  static const deviceToken = 'deviceToken';
  static const deviceType = 'deviceType';
}
