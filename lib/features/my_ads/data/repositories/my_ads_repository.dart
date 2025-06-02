import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/my_ads/data/models/ad_model.dart';
import 'package:emtelek/features/my_ads/data/models/delete_ad_request_model.dart';
import 'package:emtelek/features/my_ads/data/models/get_my_ads_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';

import 'package:emtelek/shared/models/all_response.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/features/add_property_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/models/base_response_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

// تعريف الواجهة (Interface)
abstract class MyAdsRepository {
  Future<List<GetMyAdsResponseModel>> getMyAds(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});

  Future<AllResponseModel> deleteAdProperty(
      {required DeleteAdRequestModel deleteAdRequestModel});
}

class MyAdsRepositoryImpl implements MyAdsRepository {
  final ApiConsumer api;

  MyAdsRepositoryImpl({required this.api});

  @override
  Future<List<GetMyAdsResponseModel>> getMyAds(
      {required TokenAndClintIdRequestModel
          tokenAndClintIdRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientsMyAds}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );

    if (response == null || response["ads"] == null) {
      throw Exception("No ads found");
    }

    Map<String, dynamic> adsMap = response["ads"];
    if (adsMap.isEmpty) {
      throw Exception("No ads found in the ads map");
    }

    List<dynamic> adsJson = adsMap.values.toList();
    return adsJson.map((json) => GetMyAdsResponseModel.fromJson(json)).toList();
    //return [];
  }

  @override
  Future<AllResponseModel> deleteAdProperty(
      {required DeleteAdRequestModel deleteAdRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsDelete}',
      isFormData: true,
      data: deleteAdRequestModel.toJson(),
    );

    return AllResponseModel.fromJson(response);
  }
}
