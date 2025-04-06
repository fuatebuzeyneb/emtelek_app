import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/add_listing/data/models/feature_model.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';

abstract class PropertyRepository {
  Future<PropertyAdModel> addAdProperty(
      {required PropertyAdModel propertyAdModel});

  Future<List<FeatureModel>> getFeatures();
}

class PropertyRepositoryImpl implements PropertyRepository {
  final ApiConsumer api;

  PropertyRepositoryImpl({required this.api});

  @override
  Future<PropertyAdModel> addAdProperty(
      {required PropertyAdModel propertyAdModel}) async {
    // طباعة الـ Request (البيانات التي يتم إرسالها)
    print("🔵 Request to API: ${propertyAdModel.toJson()}");

    // إرسال الطلب عبر POST
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsAdd}',
      isFormData: true,
      data: propertyAdModel.toJson(),
    );

    // طباعة الـ Response (البيانات التي يتم استلامها)
    print("🔵 Response from API: $response");

    // تحويل الاستجابة إلى PropertyAdModel
    return PropertyAdModel.fromJson(response);
  }

  @override
  Future<List<FeatureModel>> getFeatures() async {
    try {
      final response = await api.get(
        '${EndPoints.baseUrl}${EndPoints.features}',
      );

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
      return adsJson.map((json) => FeatureModel.fromJson(json)).toList();
      //return [];
    } catch (e) {
      print("Error in getMyAds: $e"); // طباعة الخطأ لمزيد من التحليل
      throw Exception("Failed to load ads: ${e.toString()}");
    }
  }
}



/*

          "Token": propertyAdModel.adModel.token,
          "ClientsId": propertyAdModel.adModel.clientId,
          "AdTitle": propertyAdModel.adModel.title,
          "CategoryId": propertyAdModel.adModel.categoryId,
          "DistrictId": propertyAdModel.adModel.districtId,
          "Price": propertyAdModel.adModel.price,
          "Currency": propertyAdModel.adModel.currency,
          "SellerType": propertyAdModel.adModel.sellerType,
          "Description": propertyAdModel.adModel.description,
          "Location": propertyAdModel.adModel.location,
          "TotalArea": propertyAdModel.totalArea,
          "NetArea": propertyAdModel.netOrBuildingArea,
          "Address": propertyAdModel.adModel.address,
          "RomeCount": propertyAdModel.romeCount,
          "FloorNumber": propertyAdModel.floorNumber,
          "BathroomCount": propertyAdModel.bathroomCount,
          "ConstructionDate": propertyAdModel.constructionDate,
          "BalconyCount": propertyAdModel.balconyCount,
          "FloorCount": propertyAdModel.floorCount,
          "Furnished": propertyAdModel.furnished,
          "ComplexName": propertyAdModel.complexName,

*/