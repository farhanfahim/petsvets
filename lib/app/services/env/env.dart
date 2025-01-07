import 'envs.dart';

class Env {
  final String? label;
  final EnvUser? user;
  final String? authBaseUrl;
  final String? baseUrl;
  final String? shareBaseUrl;
  final String? storageUrl;
  final String? paymentUrl;
  final String? notificationUrl;
  final String? paymentServiceToken;
  final String? storagePresignedToken;
  final String? authServiceToken;

  const Env({
    this.label,
    this.user,
    this.baseUrl,
    this.shareBaseUrl,
    this.authBaseUrl,
    this.storageUrl,
    this.notificationUrl,
    this.storagePresignedToken,
    this.authServiceToken,
    this.paymentUrl,
    this.paymentServiceToken,
  });

  static Env currentEnv = Envs.stagEnv;
}

class EnvUser {
  final String email;
  final String password;

  const EnvUser(this.email, this.password);
}
