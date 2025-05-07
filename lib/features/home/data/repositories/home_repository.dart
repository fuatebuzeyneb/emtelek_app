import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/home/data/models/home_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeAds();
  Future<List<AdModel>> getSearchAds({required String searchQuery});
}

class HomeRepositoryImpl implements HomeRepository {
  final ApiConsumer api;

  HomeRepositoryImpl({required this.api});

  @override
  Future<HomeModel> getHomeAds() async {
    try {
      final data = {
        "Token": getIt<CacheHelper>().getDataString(key: 'token') ?? null,
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId') ?? null,
      };

      print("Data being sent: $data");

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.adsHome}',
        isFormData: true,
        data: data,
      );

      print("Response: $response"); // طباعة الاستجابة للتحقق

      return HomeModel.fromJson(response);

      //return [];
    } catch (e) {
      print("Error in getMyAds6: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("Failed to load ads: ${e.toString()}");
    }
  }

  @override
  Future<List<AdModel>> getSearchAds({required String searchQuery}) async {
    try {
      final data = {
        "Token": getIt<CacheHelper>().getDataString(key: 'token'),
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
        "SearchQuery": searchQuery,
        "Page": 0,
        "OrderBy": "Price ASC",
      };

      print("Data being sent: $data");

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.adsSearch}',
        isFormData: true,
        data: data,
      );

      print("Response: $response"); // طباعة الاستجابة للتحقق

      if (response == null || response["data"] == null) {
        print("No ads found in the response");
        throw Exception("No ads found");
      }

      Map<String, dynamic> adsMap = response["data"];
      if (adsMap.isEmpty) {
        print("No ads found in the ads map");
        throw Exception("No ads found in the ads map");
      }

      List<dynamic> adsJson = adsMap.values.toList();
      return adsJson.map((json) => AdModel.fromJson(json)).toList();
      //return [];
    } catch (e) {
      print("Error in getMyAds7: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("Failed to load ads: ${e.toString()}");
    }
  }
}
