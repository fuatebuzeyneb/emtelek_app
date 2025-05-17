import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

class CheckPasswordRequestModel {
  final String password;

  CheckPasswordRequestModel({required this.password});

  Map<String, dynamic> toJson() {
    return {
      'Password': password,
      "Token": getIt<CacheHelper>().getDataString(key: 'token'),
      "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
    };
  }

  @override
  String toString() => 'CheckPasswordRequestModel(password: $password)';
}
