import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/all_response.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

// تعريف الواجهة (Interface)
abstract class MyAdsRepository {
  Future<List<AdsModel>> getMyAds();
  Future<AllResponseModel> updateAdProperty({
    required AdsModel adsModel,
  });
}

class MyAdsRepositoryImpl implements MyAdsRepository {
  final ApiConsumer api;

  MyAdsRepositoryImpl({required this.api});

  @override
  Future<List<AdsModel>> getMyAds() async {
    try {
      final data = {
        "Token": getIt<CacheHelper>().getDataString(key: 'token'),
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
      };

      print("Data being sent: $data");

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsMyAds}',
        isFormData: true,
        data: data,
      );

      print("Response: $response"); // طباعة الاستجابة للتحقق

      if (response == null || response["ads"] == null) {
        print("No ads found in the response");
        throw Exception("No ads found");
      }

      Map<String, dynamic> adsMap = response["ads"];
      if (adsMap.isEmpty) {
        print("No ads found in the ads map");
        throw Exception("No ads found in the ads map");
      }

      List<dynamic> adsJson = adsMap.values.toList();
      return adsJson.map((json) => AdsModel.fromJson(json)).toList();
      //return [];
    } catch (e) {
      print("Error in getMyAds: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("Failed to load ads: ${e.toString()}");
    }
  }

  @override
  Future<AllResponseModel> updateAdProperty({
    required AdsModel adsModel,
  }) async {
    // طباعة الـ Request (البيانات التي يتم إرسالها)
    print("🔵 Request to API: ${adsModel.toJson()}");

    // إرسال الطلب عبر PUT أو PATCH (حسب الـ API الخاص بك)
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsEdit}', // أو حسب بنية الـ API لديك
      isFormData: true,
      data: adsModel.toJson(),
    );

    // طباعة الـ Response (البيانات التي تم استلامها)
    print("🔵 Response from API: $response");

    // تحويل الاستجابة إلى PropertyAdModel
    return AllResponseModel.fromJson(response);
  }
}
