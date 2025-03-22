import 'package:hive/hive.dart';

part 'district_model.g.dart';

@HiveType(typeId: 1)
class DistrictModel {
  @HiveField(0)
  final int districtId;

  @HiveField(1)
  final int cityId;

  @HiveField(2)
  final String districtName;

  DistrictModel({
    required this.districtId,
    required this.cityId,
    required this.districtName,
  });

  // لتحويل JSON إلى DistrictModel
  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      districtId: json['DistrictId'],
      cityId: json['CityId'],
      districtName: json['DistrictName'],
    );
  }
}
