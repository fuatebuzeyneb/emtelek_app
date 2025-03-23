import 'package:emtelek/features/profile/data/models/ads_model.dart';

class HomeModel {
  final int carbrandsCount;
  final int districtsCount;
  final List<AdsModel> propertiesRent;
  final List<AdsModel> propertiesSell;

  HomeModel({
    required this.carbrandsCount,
    required this.districtsCount,
    required this.propertiesRent,
    required this.propertiesSell,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      carbrandsCount: json['carbrands_count'] ?? 0,
      districtsCount: json['districts_count'] ?? 0,
      propertiesRent: (json['properties_rent'] as Map<String, dynamic>?)
              ?.values
              .map((e) => AdsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      propertiesSell: (json['properties_sell'] as Map<String, dynamic>?)
              ?.values
              .map((e) => AdsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carbrands_count': carbrandsCount,
      'districts_count': districtsCount,
      'properties_rent': propertiesRent.map((e) => e.toJson()).toList(),
      'properties_sell': propertiesSell.map((e) => e.toJson()).toList(),
    };
  }
}
