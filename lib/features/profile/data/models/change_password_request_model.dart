import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

class ChangePasswordRequestModel {
  final String password;
  final String oldPassword;

  ChangePasswordRequestModel(
      {required this.password, required this.oldPassword});

  Map<String, dynamic> toJson() {
    return {
      'Password': password,
      'OldPassword': oldPassword,
      "Token": getIt<CacheHelper>().getDataString(key: 'token'),
      "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
    };
  }

  @override
  String toString() =>
      'CheckPasswordRequestModel(password: $password, oldPassword: $oldPassword)';
}
