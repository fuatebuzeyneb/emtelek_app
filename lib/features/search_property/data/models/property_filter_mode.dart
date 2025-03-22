class PropertyFilterModel {
  final int? minPrice;
  final int? maxPrice;
  final int? categoryId;
  final int? sellerType;
  final int? districtId;
  final int? cityId;
  final int? minTotalArea;
  final int? maxTotalArea;
  final int? minNetArea;
  final int? maxNetArea;
  final List<int>? roomCount;
  final int? floorCount;
  final int? bathroomCount;
  final int? furnish;
  final String? minConstructionDate;
  final String? maxConstructionDate;
  final int? balconyCount;

  PropertyFilterModel({
    required this.minPrice,
    required this.maxPrice,
    required this.categoryId,
    required this.sellerType,
    required this.districtId,
    required this.cityId,
    required this.minTotalArea,
    required this.maxTotalArea,
    required this.minNetArea,
    required this.maxNetArea,
    required this.roomCount,
    required this.floorCount,
    required this.bathroomCount,
    required this.furnish,
    required this.minConstructionDate,
    required this.maxConstructionDate,
    required this.balconyCount,
  });
  Map<String, dynamic> toJson() {
    return {
      'MinPrice': minPrice ?? 'null',
      'MaxPrice': maxPrice ?? 'null',
      'CategoryId': categoryId,
      'SellerType': sellerType ?? 'null',
      'DistrictId': districtId ?? 'null',
      'CityId': cityId ?? 'null',
      'MinTotalArea': minTotalArea ?? 'null',
      'MaxTotalArea': maxTotalArea ?? 'null',
      'MinNetArea': minNetArea ?? 'null',
      'MaxNetArea': maxNetArea ?? 'null',
      'RoomCount[]': roomCount ?? 'null',
      'FloorCount': floorCount ?? 'null',
      'BathroomCount': bathroomCount ?? 'null',
      'Furnish': furnish ?? 'null',
      'MinConstructionDate': minConstructionDate ?? 'null',
      'MaxConstructionDate': maxConstructionDate ?? 'null',
      'BalconyCount': balconyCount ?? 'null',
    };
  }
}
