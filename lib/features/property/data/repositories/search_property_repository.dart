// import 'package:emtelek/core/api/api_consumer.dart';
// import 'package:emtelek/core/api/end_points.dart';
// import 'package:emtelek/features/profile/data/models/ads_model.dart';
// import 'package:emtelek/features/property/data/models/property_filter_request_mode.dart';
// import 'package:emtelek/features/home/data/models/search_request_model.dart';
// import 'package:emtelek/features/home/data/models/search_response_model.dart';
// import 'package:emtelek/shared/services/cache_hekper.dart';
// import 'package:emtelek/shared/services/service_locator.dart';

// abstract class SearchPropertyRepository {
//   Future<List<AdModel>> getFilteredAds(PropertyFilterRequestModel filter);
//   Future<void> saveSearchFilter(
//     PropertyFilterRequestModel filter,
//   );

//   Future<SearchResponseModel> getSearchFilter({
//     required SearchRequestModel searchRequestModel,
//   });
// }

// class SearchPropertyRepositoryImpl implements SearchPropertyRepository {
//   final ApiConsumer api;

//   SearchPropertyRepositoryImpl({required this.api});

//   @override
//   Future<List<AdModel>> getFilteredAds(
//       PropertyFilterRequestModel filter) async {
//     try {
//       // طباعة البيانات التي سيتم إرسالها
//       print('🚀 Sending filter data: ${filter.toJson()}');

//       final response = await api.post(
//         '${EndPoints.baseUrl}${EndPoints.adsFilter}',
//         isFormData: true,
//         data: filter.toJson(),
//       );

//       print('----------------------------------------');
// // طباعة الاستجابة
//       print('🚀 Response: $response');

//       if (response.containsKey("data") &&
//           response["data"] != null &&
//           response["data"] != false) {
//         Map<String, dynamic> adsMap = response["data"];
//         List<dynamic> adsJson = adsMap.values.toList();

//         return adsJson.map((json) => AdModel.fromJson(json)).toList();
//       } else {
//         print("🚀 Error: Data is empty or invalid");
//         return []; // إرجاع قائمة فارغة في حالة عدم وجود بيانات صالحة
//       }
//     } catch (e) {
//       print('----------------------------------------');
//       // طباعة الخطأ في حال فشل الطلب
//       print('🚀 Error occurred: $e');
//       throw Exception("Failed to load filtered ads: ${e.toString()}");
//     }
//   }

//   @override
//   Future<void> saveSearchFilter(PropertyFilterRequestModel filter) async {
//     try {
//       print('🚀 Sending filter data: ${filter.toJson()}');

//       final response = await api.post(
//         '${EndPoints.baseUrl}${EndPoints.clientSearchesAdd}',
//         isFormData: true,
//         data: filter.toJson(),
//       );

//       print('----------------------------------------');
// // طباعة الاستجابة
//       print('🚀 Response: $response');
//     } catch (e) {
//       print('----------------------------------------');
//       // طباعة الخطأ في حال فشل الطلب
//       print('🚀 Error occurred: $e');
//       throw Exception("Failed to load filtered ads: ${e.toString()}");
//     }
//   }

//   @override
//   Future<SearchResponseModel> getSearchFilter({
//     required SearchRequestModel searchRequestModel,
//   }) async {
//     final response = await api.post(
//       '${EndPoints.baseUrl}${EndPoints.clientSearchesGet}',
//       isFormData: true,
//       data: searchRequestModel.toJson(),
//     );

//     return SearchResponseModel.fromJson(response);
//   }
// }
