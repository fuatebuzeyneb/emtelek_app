import 'package:emtelek/features/home/data/models/property_model.dart';

class GetFavoriteResponseModel {
  final String status;
  final List<Property> properties;

  GetFavoriteResponseModel({
    required this.status,
    required this.properties,
  });

  factory GetFavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    final adsMap = json['ads'] as Map<String, dynamic>;

    final properties = adsMap.values.map((adJson) {
      return Property.fromJson(adJson);
    }).toList();

    return GetFavoriteResponseModel(
      status: json['status'],
      properties: properties,
    );
  }
}
