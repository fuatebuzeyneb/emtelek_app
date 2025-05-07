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
  Future<List<AdModel>> getMyAds();
  Future<AllResponseModel> updateAdProperty({
    required AdModel adModel,
  });

  Future<AllResponseModel> deleteAdProperty({
    required int adId,
  });
}

class MyAdsRepositoryImpl implements MyAdsRepository {
  final ApiConsumer api;

  MyAdsRepositoryImpl({required this.api});

  @override
  Future<List<AdModel>> getMyAds() async {
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
      return adsJson.map((json) => AdModel.fromJson(json)).toList();
      //return [];
    } catch (e) {
      print("Error in getMyAds4: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("Failed to load ads: ${e.toString()}");
    }
  }

  @override
  Future<AllResponseModel> updateAdProperty({
    required AdModel adModel,
  }) async {
    // طباعة الـ Request (البيانات التي يتم إرسالها)
    print("🔵 Request to API: ${adModel.toJson()}");

    // إرسال الطلب عبر PUT أو PATCH (حسب الـ API الخاص بك)
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsEdit}', // أو حسب بنية الـ API لديك
      isFormData: true,
      data: adModel.toJson(),
    );

    // طباعة الـ Response (البيانات التي تم استلامها)
    print("🔵 Response from API: $response");

    // تحويل الاستجابة إلى PropertyAdModel
    return AllResponseModel.fromJson(response);
  }

  @override
  Future<AllResponseModel> deleteAdProperty({required int adId}) async {
    // إرسال الطلب عبر PUT أو PATCH (حسب الـ API الخاص بك)
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsDelete}', // أو حسب بنية الـ API لديك
      isFormData: true,
      data: {
        "Token": getIt<CacheHelper>().getDataString(key: 'token'),
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
        "AdId": adId
      },
    );

    // طباعة الـ Response (البيانات التي تم استلامها)
    print("🔵 Response from API================: $response");

    // تحويل الاستجابة إلى PropertyAdModel
    return AllResponseModel.fromJson(response);
  }
}
