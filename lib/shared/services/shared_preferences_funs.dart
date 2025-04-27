import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

void saveLanguage(String value) {
  getIt<CacheHelper>().saveData(key: 'Lang', value: value);
}

void saveEmail(String value) {
  getIt<CacheHelper>().saveData(key: 'email', value: value);
}

void savePassword(String value) {
  getIt<CacheHelper>().saveData(key: 'password', value: value);
}

void saveToken(String value) {
  getIt<CacheHelper>().saveData(key: 'token', value: value);
}

void saveFirstName(String value) {
  getIt<CacheHelper>().saveData(key: 'firstName', value: value);
}

void saveLastName(String value) {
  getIt<CacheHelper>().saveData(key: 'lastName', value: value);
}

void saveClientId(int value) {
  getIt<CacheHelper>().saveData(key: 'clientId', value: value);
}

// void saveAddress(String value) {
//   getIt<CacheHelper>().saveData(key: 'address', value: value);
// }

// void savePhoneNumber(String value) {
//   getIt<CacheHelper>().saveData(key: 'phoneNumber', value: value);
// }

// void saveDistrictId(int value) {
//   getIt<CacheHelper>().saveData(key: 'districtId', value: value);
// }

void saveJoinDate(String value) {
  getIt<CacheHelper>().saveData(key: 'joinDate', value: value);
}

void saveUserImage(String value) {
  getIt<CacheHelper>().saveData(key: 'userImage', value: value);
}

void saveCurrencyCode(String value) {
  getIt<CacheHelper>().saveData(key: 'currencyCode', value: value);
}
