import 'package:hive/hive.dart';

part 'city_model.g.dart';

@HiveType(typeId: 0)
class CityModel {
  @HiveField(0)
  final int cityId;

  @HiveField(1)
  final String cityName;

  CityModel({required this.cityId, required this.cityName});

  // لتحويل JSON إلى CityModel
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['CityId'],
      cityName: json['CityName'],
    );
  }
}