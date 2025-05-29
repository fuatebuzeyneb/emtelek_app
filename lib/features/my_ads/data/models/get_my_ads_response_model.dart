import 'package:emtelek/features/home/data/models/property_model.dart';

class GetMyAdsResponseModel {
  final Property property;

  GetMyAdsResponseModel({
    required this.property,
  });

  factory GetMyAdsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetMyAdsResponseModel(
      property: Property.fromJson(json),
    );
  }
}
