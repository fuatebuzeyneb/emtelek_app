import 'package:dio/dio.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/add_property_listing/data/models/add_property_ad_request_model.dart';
import 'package:emtelek/features/add_property_listing/data/models/feature_model.dart';
import 'package:emtelek/features/add_property_listing/data/models/property_add_model.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/profile/data/models/featur_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class PropertyRepository {
  Future<void> addAdProperty({
    required AddPropertyAdRequestModel addPropertyAdRequestModel,
    required List<XFile> images,
    required XFile mainImage,
    List<int>? featureIdList,
  });

  Future<void> editAdProperty({
    required AddPropertyAdRequestModel addPropertyAdRequestModel,
    required List<XFile> images,
    required XFile mainImage,
    List<int>? featureIdList,
  });

  Future<List<FeatureModel>> getFeatures();
}

class PropertyRepositoryImpl implements PropertyRepository {
  final ApiConsumer api;

  PropertyRepositoryImpl({required this.api});

  @override
  // Future<AdModel> addAdProperty({required AdModel propertyAdModel}) async {
  //   // طباعة الـ Request (البيانات التي يتم إرسالها)
  //   print("🔵 Request to API: ${propertyAdModel.toJson()}");

  //   // إرسال الطلب عبر POST
  //   final response = await api.post(
  //     '${EndPoints.baseUrl}${EndPoints.adsAdd}',
  //     isFormData: true,
  //     data: propertyAdModel.toJson(),
  //   );

  //   // طباعة الـ Response (البيانات التي يتم استلامها)
  //   print("🔵 Response from API: $response");

  //   // تحويل الاستجابة إلى PropertyAdModel
  //   return AdModel.fromJson(response);
  // }

  Future<void> addAdProperty(
      {required AddPropertyAdRequestModel addPropertyAdRequestModel,
      required List<XFile> images,
      required XFile mainImage,
      List<int>? featureIdList}) async {
    // طباعة الـ Request (البيانات التي يتم إرسالها)
    final formData = FormData();

    // 1. نضيف الحقول النصية يدويًا من toJson()
    final dataMap = addPropertyAdRequestModel.toJson();
    dataMap.forEach((key, value) {
      formData.fields.add(
        MapEntry(
          key,
          value?.toString() ?? '',
        ),
      );
    });

    // 2. نضيف الصور المتعددة
    for (final image in images) {
      formData.files.add(MapEntry(
        'Images[]',
        await MultipartFile.fromFile(image.path, filename: image.name),
      ));
    }

    formData.files.add(MapEntry(
      'MainImage',
      await MultipartFile.fromFile(mainImage.path, filename: mainImage.name),
    ));

    if (featureIdList != null) {
      for (final featureId in featureIdList) {
        formData.fields.add(
          MapEntry(
            'Features[]',
            featureId.toString(),
          ),
        );
      }
    } else {
      formData.fields.add(
        MapEntry(
          'Features',
          null.toString(),
        ),
      );
    }

    print(images[0]);

    print("🔵 Fields: ${formData.fields}");
    for (var file in formData.files) {
      final multipart = file.value as MultipartFile;
      print('📷 Field: ${file.key} | File: ${multipart.filename}');
    }

    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsAdd}',
      data: formData,
      isFormData: false,
    );

    print("🔵 Response from API: $response");
  }

  Future<void> editAdProperty(
      {required AddPropertyAdRequestModel addPropertyAdRequestModel,
      required List<XFile> images,
      required XFile mainImage,
      List<int>? featureIdList}) async {
    // طباعة الـ Request (البيانات التي يتم إرسالها)
    final formData = FormData();

    // 1. نضيف الحقول النصية يدويًا من toJson()
    final dataMap = addPropertyAdRequestModel.toJson();
    dataMap.forEach((key, value) {
      formData.fields.add(
        MapEntry(
          key,
          value?.toString() ?? '',
        ),
      );
    });

    // 2. نضيف الصور المتعددة
    for (final image in images) {
      formData.files.add(MapEntry(
        'Images[]',
        await MultipartFile.fromFile(image.path, filename: image.name),
      ));
    }

    formData.files.add(MapEntry(
      'MainImage',
      await MultipartFile.fromFile(mainImage.path, filename: mainImage.name),
    ));

    if (featureIdList != null) {
      for (final featureId in featureIdList) {
        formData.fields.add(
          MapEntry(
            'Features[]',
            featureId.toString(),
          ),
        );
      }
    } else {
      formData.fields.add(
        MapEntry(
          'Features',
          null.toString(),
        ),
      );
    }

    print(images[0]);

    print("🔵 Fields: ${formData.fields}");
    for (var file in formData.files) {
      final multipart = file.value as MultipartFile;
      print('📷 Field: ${file.key} | File: ${multipart.filename}');
    }

    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsEdit}',
      data: formData,
      isFormData: false,
    );

    print("🔵 Response from API: $response");
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
      print("Error in getMyAds1: $e"); // طباعة الخطأ لمزيد من التحليل
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