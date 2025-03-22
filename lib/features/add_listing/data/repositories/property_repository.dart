import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';

abstract class PropertyRepository {
  Future<PropertyAdModel> addAdProperty(
      {required PropertyAdModel propertyAdModel});
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