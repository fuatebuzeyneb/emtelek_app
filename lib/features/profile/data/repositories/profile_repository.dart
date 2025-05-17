import 'package:dio/dio.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/profile/data/models/change_password_request_model.dart';
import 'package:emtelek/features/profile/data/models/change_password_response_model.dart';
import 'package:emtelek/features/profile/data/models/check_password_request_model.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

// تعريف الواجهة (Interface)
abstract class ProfileRepository {
  Future<GetUserResponseModel> getUserData(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});

  Future<BaseResponseModel> deleteUserAccount(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});
  Future<EditUserResponseModel> editUserData(
      {required EditUserRequestModel editUserRequestModel});

  Future<BaseResponseModel> checkPass(
      {required CheckPasswordRequestModel checkPasswordRequestModel});
  Future<ChangePasswordResponseModel> changePass(
      {required ChangePasswordRequestModel changePasswordRequestModel});
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
    final data = editUserRequestModel.toJson();

    if (editUserRequestModel.image != null) {
      data['Image'] = await MultipartFile.fromFile(
        editUserRequestModel.image!.path,
        filename: editUserRequestModel.image!.path.split('/').last,
      );
    }
    final formData = FormData.fromMap(data);
    final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsEdit}',
        isFormData: false,
        data: formData);
    return EditUserResponseModel.fromJson(response);
  }

  @override
  Future<BaseResponseModel> checkPass(
      {required CheckPasswordRequestModel checkPasswordRequestModel}) async {
    final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsCheckPass}',
        isFormData: true,
        data: checkPasswordRequestModel.toJson());
    return BaseResponseModel.fromJson(response);
  }

  @override
  Future<ChangePasswordResponseModel> changePass(
      {required ChangePasswordRequestModel changePasswordRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientsChangePass}',
      isFormData: true,
      data: changePasswordRequestModel.toJson(),
    );
    return ChangePasswordResponseModel.fromJson(response);
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
