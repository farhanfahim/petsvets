import 'env.dart';

class Envs {
  //staging Environment
  static const Env stagEnv = Env(
      label: 'Staging',
      user: EnvUsers.devUser,
      authBaseUrl: '',
      baseUrl: 'https://petsvet-backend.tekstagearea.com/api/v1',
      shareBaseUrl: '',
      storageUrl: 'https://s3-presigned-svc.tekstagearea.com/api/v1',
      notificationUrl: '',
      authServiceToken: '',
      storagePresignedToken: 'QzFkxMuThalnNIEorRaD');
}

class EnvUsers {
  static const EnvUser devUser = EnvUser(
    'farhan@yopmail.com',
    'Demo@123',
  );
}
