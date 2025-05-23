import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/search_property/data/models/property_filter_request_mode.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

abstract class SearchPropertyRepository {
  Future<List<AdModel>> getFilteredAds(PropertyFilterRequestModel filter);
  Future<void> saveSearchFilter(
    PropertyFilterRequestModel filter,
  );

  Future<List<PropertyFilterRequestModel>> getSearchFilter();
}

class SearchPropertyRepositoryImpl implements SearchPropertyRepository {
  final ApiConsumer api;

  SearchPropertyRepositoryImpl({required this.api});

  @override
  Future<List<AdModel>> getFilteredAds(
      PropertyFilterRequestModel filter) async {
    try {
      // طباعة البيانات التي سيتم إرسالها
      print('🚀 Sending filter data: ${filter.toJson()}');

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.adsFilter}',
        isFormData: true,
        data: filter.toJson(),
      );

      print('----------------------------------------');
// طباعة الاستجابة
      print('🚀 Response: $response');

      if (response.containsKey("data") &&
          response["data"] != null &&
          response["data"] != false) {
        Map<String, dynamic> adsMap = response["data"];
        List<dynamic> adsJson = adsMap.values.toList();

        return adsJson.map((json) => AdModel.fromJson(json)).toList();
      } else {
        print("🚀 Error: Data is empty or invalid");
        return []; // إرجاع قائمة فارغة في حالة عدم وجود بيانات صالحة
      }
    } catch (e) {
      print('----------------------------------------');
      // طباعة الخطأ في حال فشل الطلب
      print('🚀 Error occurred: $e');
      throw Exception("Failed to load filtered ads: ${e.toString()}");
    }
  }

  @override
  Future<void> saveSearchFilter(PropertyFilterRequestModel filter) async {
    try {
      print('🚀 Sending filter data: ${filter.toJson()}');

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientSearchesAdd}',
        isFormData: true,
        data: filter.toJson(),
      );

      print('----------------------------------------');
// طباعة الاستجابة
      print('🚀 Response: $response');
    } catch (e) {
      print('----------------------------------------');
      // طباعة الخطأ في حال فشل الطلب
      print('🚀 Error occurred: $e');
      throw Exception("Failed to load filtered ads: ${e.toString()}");
    }
  }

  @override
  Future<List<PropertyFilterRequestModel>> getSearchFilter() async {
    try {
      // طباعة البيانات التي سيتم إرسالها

      final response = await api.post(
          '${EndPoints.baseUrl}${EndPoints.clientSearchesGet}',
          isFormData: true,
          data: {
            "Token": getIt<CacheHelper>().getDataString(key: 'token'),
            "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
          });

      print('----------------------------------------');
// طباعة الاستجابة
      print('🚀 Response: $response');

      if (response.containsKey("data") &&
          response["data"] != null &&
          response["data"] != false) {
        Map<String, dynamic> adsMap = response["data"];
        List<dynamic> adsJson = adsMap.values.toList();

        return adsJson
            .map((json) => PropertyFilterRequestModel.fromJson(json))
            .toList();
      } else {
        print("🚀 Error: Data is empty or invalid");
        return []; // إرجاع قائمة فارغة في حالة عدم وجود بيانات صالحة
      }
    } catch (e) {
      print('----------------------------------------');
      // طباعة الخطأ في حال فشل الطلب
      print('🚀 Error occurred: $e');
      throw Exception("Failed to load filtered ads: ${e.toString()}");
    }
  }

  //     final response = await api.post(
  //       '${EndPoints.baseUrl}${EndPoints.adsFilter}',
  //       isFormData: true,
  //       data: data,
  //     );

  //     // التحقق من حالة الاستجابة (statusCode)
  //     if (response.statusCode == 200) {
  //       print('----------------------------------------');
  //       // طباعة الاستجابة
  //       print('🚀 Response: $response');

  //       if (response.containsKey("data") && response["data"] != null) {
  //         Map<String, dynamic> adsMap = response["data"];
  //         List<dynamic> adsJson = adsMap.values.toList();

  //         return adsJson.map((json) => AdsModel.fromJson(json)).toList();
  //       } else {
  //         print("🚀 No data found in the response.");
  //         return []; // إرجاع قائمة فارغة إذا لم تكن هناك بيانات
  //       }
  //     } else {
  //       print("🚀 Error: Failed with status code: ${response.statusCode}");
  //       return []; // إرجاع قائمة فارغة في حالة وجود خطأ
  //     }
  //   } catch (e) {
  //     print('----------------------------------------');
  //     // طباعة الخطأ في حال فشل الطلب
  //     print('🚀 Error occurred: $e');
  //     throw Exception("Failed to load filtered ads: ${e.toString()}");
  //   }
  // }
}
