import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
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
  Future<AccountResponseModel> getAccountSettings();
  Future<AccountResponseModel> editAccountSettings(
      {required Map<String, dynamic> accountResponseModel});
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiConsumer api;

  ProfileRepositoryImpl({required this.api});

  @override
  Future<AccountResponseModel> getAccountSettings() async {
    try {
      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsGet}',
        isFormData: true,
        data: {
          "Token": getIt<CacheHelper>().getDataString(key: 'token'),
          "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
        },
      );
      return AccountResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to load account settings: ${e.toString()}");
    }
  }

  @override
  Future<AccountResponseModel> editAccountSettings(
      {required Map<String, dynamic> accountResponseModel}) async {
    try {
      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsEdit}',
        isFormData: true,
        data: accountResponseModel,
      );
      return AccountResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to edit account settings: ${e.toString()}");
    }
  }
}
