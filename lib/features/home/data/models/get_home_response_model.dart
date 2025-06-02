import 'package:emtelek/features/home/data/models/property_model.dart';

class GetHomeResponseModel {
  final String status;
  final int carbrandsCount;
  final int districtsCount;
  final List<Property>? propertiesRent;
  final List<Property>? propertiesSell;
  final List<Property>? vehicles;

  GetHomeResponseModel({
    required this.status,
    required this.carbrandsCount,
    required this.districtsCount,
    required this.propertiesRent,
    required this.propertiesSell,
    required this.vehicles,
  });

  factory GetHomeResponseModel.fromJson(Map<String, dynamic> json) {
    final rentRaw = json['properties_rent'];
    final sellRaw = json['properties_sell'];
    final vehiclesRaw = json['vehicles'];

    return GetHomeResponseModel(
      status: json['status'] ?? '',
      carbrandsCount: json['carbrands_count'] ?? 0,
      districtsCount: json['districts_count'] ?? 0,
      propertiesRent: rentRaw is List
          ? rentRaw.map((e) => Property.fromJson(e)).toList()
          : rentRaw is Map
              ? rentRaw.values.map((e) => Property.fromJson(e)).toList()
              : [],
      propertiesSell: sellRaw is List
          ? sellRaw.map((e) => Property.fromJson(e)).toList()
          : sellRaw is Map
              ? sellRaw.values.map((e) => Property.fromJson(e)).toList()
              : [],
      vehicles: vehiclesRaw is List
          ? vehiclesRaw.map((e) => Property.fromJson(e)).toList()
          : vehiclesRaw is Map
              ? vehiclesRaw.values.map((e) => Property.fromJson(e)).toList()
              : [],
    );
  }
}
