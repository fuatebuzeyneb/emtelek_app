import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

abstract class FavoritesRepository {
  Future<List<AdsModel>> getMyFavoriteAds();
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final ApiConsumer api;

  FavoritesRepositoryImpl({required this.api});

  @override
  Future<List<AdsModel>> getMyFavoriteAds() async {
    try {
      final data = {
        "Token": getIt<CacheHelper>().getDataString(key: 'token'),
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
      };

      print("Data being sent: $data");

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsFavoriteAds}',
        isFormData: true,
        data: data,
      );

      print("Response: $response"); // طباعة الاستجابة للتحقق

      if (response == null ||
          response["ads"] == null ||
          response["ads"] == false) {
        print("No ads found in the response");
        throw Exception("No ads found");
      }

      var adsData = response["ads"];

      if (adsData is! Map<String, dynamic> || adsData.isEmpty) {
        print("No ads found in the ads map");
        throw Exception("No ads found");
      }

      List<dynamic> adsJson = adsData.values.toList();
      return adsJson.map((json) => AdsModel.fromJson(json)).toList();
    } catch (e) {
      print("Error in getMyAds: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("No ads found"); // رمي استثناء واحد فقط
    }
  }
}
