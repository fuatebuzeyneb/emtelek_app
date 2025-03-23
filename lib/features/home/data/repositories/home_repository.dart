import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/home/data/models/home_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeAds();
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
      print("Error in getMyAds: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("Failed to load ads: ${e.toString()}");
    }
  }
}
