class ContentModel {
  final List<int>? roomCount;
  final List<int>? cityId;
  final dynamic minPrice;
  final dynamic maxPrice;
  final dynamic categoryId;
  final dynamic minTotalArea;
  final dynamic maxTotalArea;
  final List<int>? districtId;

  ContentModel({
    this.roomCount,
    this.cityId,
    this.minPrice,
    this.maxPrice,
    this.categoryId,
    this.minTotalArea,
    this.maxTotalArea,
    this.districtId,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    List<int>? parseIntList(dynamic value) {
      if (value is List) {
        return value.map((e) => int.tryParse(e.toString()) ?? 0).toList();
      }
      return null;
    }

    return ContentModel(
      roomCount: parseIntList(json['RoomCount']),
      cityId: parseIntList(json['CityId']),
      minPrice: json['MinPrice'] as dynamic,
      maxPrice: json['MaxPrice'] as dynamic,
      categoryId: json['CategoryId'] as dynamic,
      minTotalArea: json['MinTotalArea'] as dynamic,
      maxTotalArea: json['MaxTotalArea'] as dynamic,
      districtId: parseIntList(json['DistrictId']),
    );
  }
}
