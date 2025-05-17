import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/errors/exceptions.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/profile/data/models/change_password_request_model.dart';
import 'package:emtelek/features/profile/data/models/change_password_response_model.dart';
import 'package:emtelek/features/profile/data/models/check_password_request_model.dart';
import 'package:emtelek/features/profile/data/models/edit_user_request_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/features/profile/data/models/get_user_response_model.dart';
import 'package:emtelek/features/profile/data/repositories/profile_repository.dart';
import 'package:emtelek/shared/models/add-ads-models/add_ad_model.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/services/shared_preferences_funs.dart';
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

  GetUserResponseModel? userData;

  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> getUserData(
      {required TokenAndClintIdRequestModel
          tokenAndClintIdRequestModel}) async {
    emit(UserDataLoading());
    print('TokenAndClintIdRequestModel: $tokenAndClintIdRequestModel');
    try {
      final response = await profileRepository.getUserData(
        tokenAndClintIdRequestModel: tokenAndClintIdRequestModel,
      );
      userData = response;
      emit(GetAccountSettingsSuccess());
    } catch (e) {
      emit(UserDataFailure(errorMassage: e.toString()));
    }
  }

  Future<void> deleteUserAccount(
      {required TokenAndClintIdRequestModel
          tokenAndClintIdRequestModel}) async {
    emit(UserDataLoading());
    print('TokenAndClintIdRequestModel: $tokenAndClintIdRequestModel');

    try {
      final response = await profileRepository.deleteUserAccount(
        tokenAndClintIdRequestModel: tokenAndClintIdRequestModel,
      );

      if (response.isSuccess) {
        emit(DeleteAccountSettingsSuccess());
        await getIt<CacheHelper>().removeData(key: 'token');
        await getIt<CacheHelper>().removeData(key: 'email');
        await getIt<CacheHelper>().removeData(key: 'joinDate');
        await getIt<CacheHelper>().removeData(key: 'firstName');
        await getIt<CacheHelper>().removeData(key: 'lastName');
        await getIt<CacheHelper>().removeData(key: 'clientId');
        await getIt<CacheHelper>().removeData(key: 'userImage');
      } else {
        emit(UserDataFailure(errorMassage: response.msg ?? "Unknown Error"));
      }
    } on ServerException catch (e) {
      emit(UserDataFailure(errorMassage: e.errorModel.errorMessage));
    }
  }

  String? editFirstName;
  String? editLastName;
  String? editPhoneNumber;
  int? editDistrictId;
  String? editAddress;
  File? editImage;

  Future<void> editUserData({
    required EditUserRequestModel editUserRequestModel,
  }) async {
    emit(UserDataLoading());

    print('editUserRequestModel: $editUserRequestModel');
    try {
      final response = await profileRepository.editUserData(
        editUserRequestModel: editUserRequestModel,
      );

      await getIt<CacheHelper>().removeData(key: 'token');
      await getIt<CacheHelper>().removeData(key: 'email');
      await getIt<CacheHelper>().removeData(key: 'joinDate');
      await getIt<CacheHelper>().removeData(key: 'firstName');
      await getIt<CacheHelper>().removeData(key: 'lastName');
      await getIt<CacheHelper>().removeData(key: 'clientId');
      await getIt<CacheHelper>().removeData(key: 'userImage');
      saveToken(response.token!);
      saveEmail(response.data!.email!);

      saveFirstName(response.data!.firstName!);
      saveLastName(response.data!.lastName!);
      saveClientId(response.data!.clientId!);
      saveJoinDate(response.data!.subscriptionDate!);
      saveUserImage(response.data!.image!);
      emit(EditAccountSettingsSuccess());
    } catch (e) {
      emit(UserDataFailure(errorMassage: e.toString()));
    }
  }

  Future<void> checkPass(
      {required CheckPasswordRequestModel checkPasswordRequestModel}) async {
    try {
      final response = await profileRepository.checkPass(
          checkPasswordRequestModel: checkPasswordRequestModel);

      if (response.msg == 'true') {
        emit(CheckPassSuccess());
      } else {
        emit(CheckPassFailure(errorMassage: response.msg ?? "Unknown Error"));
      }
    } on ServerException catch (e) {
      emit(CheckPassFailure(errorMassage: e.errorModel.errorMessage));
    }
  }

  Future<ChangePasswordResponseModel?> changePass({
    required ChangePasswordRequestModel changePasswordRequestModel,
  }) async {
    emit(ChangePassLoading());
    try {
      final response = await profileRepository.changePass(
        changePasswordRequestModel: changePasswordRequestModel,
      );

      emit(ChangePassSuccess());

      await getIt<CacheHelper>().removeData(key: 'token');
      saveToken(response.token);

      return response;
    } catch (e) {
      emit(ChangePassFailure(errorMassage: e.toString()));
      return null;
    }
  }
}





/*


Future<void> editUserData({
    required EditUserRequestModel
        editUserRequestModel,

  }) async {
    emit(UserDataLoading());
    try {
      final addressData = userData?.addressData;

      final districtIdValue = districtId ?? addressData?.districtId ?? '';
      final addressValue = address ?? addressData?.address ?? '';

      final clientId = getIt<CacheHelper>().getData(key: 'clientId');
      final email = getIt<CacheHelper>().getData(key: 'email');
      final token = getIt<CacheHelper>().getDataString(key: 'token');

      final requestBody = {
        'Token': token,
        'ClientId': clientId,
        'FirstName': firstName ?? userData!.data?.firstName ?? '',
        'LastName': lastName ?? userData!.data?.lastName ?? '',
        'PhoneNumber': phoneNumber ?? userData!.data?.phoneNumber ?? '',
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

      final response = await profileRepository.editUserData(
        accountResponseModel: requestBody,
      );

      await getIt<CacheHelper>().removeData(key: 'token');
      await getIt<CacheHelper>().removeData(key: 'password');
      await getIt<CacheHelper>().removeData(key: 'email');
      await getIt<CacheHelper>().removeData(key: 'joinDate');
      await getIt<CacheHelper>().removeData(key: 'firstName');
      await getIt<CacheHelper>().removeData(key: 'lastName');
      await getIt<CacheHelper>().removeData(key: 'clientId');

      saveToken(response.token!);
      saveEmail(response.data!.email!);
      savePassword('123456'); // انت هنا حاط باسورد ثابت
      saveFirstName(response.data!.firstName!);
      saveLastName(response.data!.lastName!);
      saveClientId(response.data!.clientId!);
      saveJoinDate(response.data!.subscriptionDate!);
      saveUserImage(response.data!.image!);
      emit(EditAccountSettingsSuccess());
    } catch (e) {
      emit(UserDataFailure(errorMassage: e.toString()));
    }
  }

*/