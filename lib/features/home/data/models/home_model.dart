import 'package:emtelek/features/profile/data/models/ads_model.dart';

class HomeModel {
  final int carbrandsCount;
  final int districtsCount;
  final List<AdModel> propertiesRent;
  final List<AdModel> propertiesSell;
  final bool vehicles;

  HomeModel(
      {required this.carbrandsCount,
      required this.districtsCount,
      required this.propertiesRent,
      required this.propertiesSell,
      required this.vehicles});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final propertiesRentJson = json['properties_rent'];
    final propertiesSellJson = json['properties_sell'];

    return HomeModel(
      vehicles: json['vehicles'] ?? false,
      carbrandsCount: json['carbrands_count'] ?? 0,
      districtsCount: json['districts_count'] ?? 0,
      propertiesRent: propertiesRentJson is Map<String, dynamic>
          ? propertiesRentJson.values
              .map((e) => AdModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      propertiesSell: propertiesSellJson is Map<String, dynamic>
          ? propertiesSellJson.values
              .map((e) => AdModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbrands_count': carbrandsCount,
      'districts_count': districtsCount,
      'properties_rent': propertiesRent.map((e) => e.toJson()).toList(),
      'properties_sell': propertiesSell.map((e) => e.toJson()).toList(),
      'vehicles': vehicles
    };
  }
}
