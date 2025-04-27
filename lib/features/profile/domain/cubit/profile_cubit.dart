import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/profile/data/repositories/profile_repository.dart';
import 'package:emtelek/shared/models/add-ads-models/add_ad_model.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   final ProfileRepository profileRepository;

//   ClientsResponseModel? accountData;

//   ProfileCubit(this.profileRepository) : super(ProfileInitial());

//   Future<void> getAccountSettings() async {
//     print('----------------------------------');
//     emit(GetAccountSettingsLoading());
//     try {
//       final rawData = await profileRepository.getAccountSettings();

//       accountData = rawData;

//       emit(GetAccountSettingsSuccess());
//     } catch (e) {
//       print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
//       emit(GetAccountSettingsFailure(errorMassage: e.toString()));
//     }
//   }

//   String? editFirstName;
//   String? editLastName;
//   String? editPhoneNumber;
//   int? editDistrictId;
//   String? editAddress;
//   File? editImage;

//   Future<void> editAccountSettings({
//     required String? firstName,
//     required String? lastName,
//     required String? phoneNumber,
//     required File? image,
//     required String? address,
//     required int? districtId,
//   }) async {
//     emit(EditAccountSettingsLoading());
//     try {
//       final addressData = accountData?.addressData;

//       String getDistrictId(dynamic addressData) {
//         if (addressData is Map) {
//           return addressData['districtId'] ?? '';
//         }
//         return '';
//       }

//       String getAddress(dynamic addressData) {
//         if (addressData is Map) {
//           return addressData['address'] ?? '';
//         }
//         return '';
//       }

//       final districtIdValue = districtId ?? getDistrictId(addressData);
//       final addressValue = address ?? getAddress(addressData);
//       final clientId = getIt<CacheHelper>().getData(key: 'clientId');
//       final email = getIt<CacheHelper>().getData(key: 'email');
//       final token = getIt<CacheHelper>().getDataString(key: 'token');
//       final requestBody = {
//         'Token': token,
//         'ClientId': clientId,
//         'FirstName': firstName ?? accountData!.data!.firstName!,
//         'LastName': lastName ?? accountData!.data!.lastName!,
//         'PhoneNumber': phoneNumber ?? accountData!.data!.phoneNumber!,
//         'Email': email,
//         'Password': 123456,
//         if (image != null)
//           'Image': await MultipartFile.fromFile(
//             image.path,
//             filename: image.path.split('/').last,
//           ),
//         'DistrictId': districtIdValue,
//         'Address': addressValue,
//       };

//       await profileRepository.editAccountSettings(
//           clientsResponseModel: requestBody);
//       ();
//       emit(EditAccountSettingsSuccess());
//     } catch (e) {
//       emit(EditAccountSettingsFailure(errorMassage: e.toString()));
//     }
//   }
// }

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  AccountResponseModel? accountData;

  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> getAccountSettings() async {
    emit(GetAccountSettingsLoading());
    try {
      final rawData = await profileRepository.getAccountSettings();
      accountData = rawData;
      emit(GetAccountSettingsSuccess());
    } catch (e) {
      emit(GetAccountSettingsFailure(errorMassage: e.toString()));
    }
  }

  String? editFirstName;
  String? editLastName;
  String? editPhoneNumber;
  int? editDistrictId;
  String? editAddress;
  File? editImage;

  Future<void> editAccountSettings({
    required String? firstName,
    required String? lastName,
    required String? phoneNumber,
    required File? image,
    required String? address,
    required int? districtId,
  }) async {
    emit(EditAccountSettingsLoading());
    try {
      final addressData = accountData?.addressData;

      final districtIdValue = districtId ?? addressData?.districtId ?? '';
      final addressValue = address ?? addressData?.address ?? '';

      final clientId = getIt<CacheHelper>().getData(key: 'clientId');
      final email = getIt<CacheHelper>().getData(key: 'email');
      final token = getIt<CacheHelper>().getDataString(key: 'token');

      final requestBody = {
        'Token': token,
        'ClientId': clientId,
        'FirstName': firstName ?? accountData!.data?.firstName ?? '',
        'LastName': lastName ?? accountData!.data?.lastName ?? '',
        'PhoneNumber': phoneNumber ?? accountData!.data?.phoneNumber ?? '',
        'Email': email,
        'Password': 123456,
        if (image != null)
          'Image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        'DistrictId': districtIdValue,
        'Address': addressValue,
      };

      await profileRepository.editAccountSettings(
          accountResponseModel: requestBody);
      emit(EditAccountSettingsSuccess());
    } catch (e) {
      emit(EditAccountSettingsFailure(errorMassage: e.toString()));
    }
  }
}
