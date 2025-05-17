import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/profile/data/models/edit_user_request_model.dart';
import 'package:emtelek/features/profile/data/models/edit_user_response_model.dart';
import 'package:emtelek/shared/models/base_response_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/features/profile/data/models/get_user_response_model.dart';
import 'package:emtelek/shared/models/all_response.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

// تعريف الواجهة (Interface)
abstract class ProfileRepository {
  Future<GetUserResponseModel> getUserData(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});

  Future<BaseResponseModel> deleteUserAccount(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});
  Future<EditUserResponseModel> editUserData(
      {required EditUserRequestModel editUserRequestModel});

  Future<AllResponseModel> checkPass({required String password});
  Future<void> changePass(
      {required String password, required String oldPassword});
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiConsumer api;

  ProfileRepositoryImpl({required this.api});

  @override
  Future<GetUserResponseModel> getUserData(
      {required TokenAndClintIdRequestModel
          tokenAndClintIdRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientsGet}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );
    return GetUserResponseModel.fromJson(response);
  }

  @override
  Future<EditUserResponseModel> editUserData(
      {required EditUserRequestModel editUserRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientsEdit}',
      isFormData: true,
      data: editUserRequestModel.toJson(),
    );
    return EditUserResponseModel.fromJson(response);
  }

  @override
  Future<AllResponseModel> checkPass({required String password}) async {
    try {
      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsCheckPass}',
        isFormData: true,
        data: {
          "Token": getIt<CacheHelper>().getDataString(key: 'token'),
          "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
          "Password": password
        },
      );
      return AllResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to load account settings: ${e.toString()}");
    }
  }

  @override
  Future<void> changePass(
      {required String password, required String oldPassword}) async {
    try {
      await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsChangePass}',
        isFormData: true,
        data: {
          "Token": getIt<CacheHelper>().getDataString(key: 'token'),
          "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
          "Password": password,
          "OldPassword": oldPassword
        },
      );
    } catch (e) {
      throw Exception("Failed to load account settings: ${e.toString()}");
    }
  }

  @override
  Future<BaseResponseModel> deleteUserAccount(
      {required TokenAndClintIdRequestModel
          tokenAndClintIdRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientsDelete}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );
    return BaseResponseModel.fromJson(response);
  }
}
