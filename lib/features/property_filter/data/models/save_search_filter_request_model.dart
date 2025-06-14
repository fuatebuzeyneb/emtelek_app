class SaveSearchFilterRequestModel {
  final int clintId;
  final String token;
  final String filterName;
  final List<int>? roomCount;
  final List<int>? cityId;
  final double? minPrice;
  final double? maxPrice;
  final int categoryId;
  final double? minTotalArea;
  final double? maxTotalArea;
  final List<int>? districtId;
  final bool? furnish;

  SaveSearchFilterRequestModel({
    this.roomCount,
    this.cityId,
    this.minPrice,
    this.maxPrice,
    this.minTotalArea,
    this.maxTotalArea,
    this.districtId,
    this.furnish,
    required this.filterName,
    required this.clintId,
    required this.token,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'clintId': clintId,
      'token': token,
      'filterName': filterName,
      'roomCount': roomCount,
      'cityId': cityId,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'categoryId': categoryId,
      'minTotalArea': minTotalArea,
      'maxTotalArea': maxTotalArea,
      'districtId': districtId,
      'furnish': furnish,
    };
  }
}
