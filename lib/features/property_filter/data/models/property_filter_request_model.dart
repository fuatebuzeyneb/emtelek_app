class PropertyFilterRequestModel {
  final String? token;
  final dynamic clientId;
  final dynamic categoryId;
  final dynamic sellerType;
  final dynamic roomCount;
  final String? furnish;
  final dynamic cityId;
  final dynamic districtId;
  final dynamic bathroomCount;
  final dynamic minPrice;
  final dynamic maxPrice;
  final int? minTotalArea;
  final int? maxTotalArea;
  final dynamic orderBy;
  final String? searchTitle;
  final int? page;

  PropertyFilterRequestModel({
    required this.token,
    required this.clientId,
    required this.categoryId,
    required this.sellerType,
    required this.roomCount,
    required this.furnish,
    required this.cityId,
    required this.districtId,
    required this.bathroomCount,
    required this.minPrice,
    required this.maxPrice,
    required this.minTotalArea,
    required this.maxTotalArea,
    required this.orderBy,
    required this.searchTitle,
    required this.page,
  });

  Map<String, dynamic> toJson() {
    return {
      'Token': token ?? 'null',
      'ClientId': clientId ?? 'null',
      'MinPrice': minPrice ?? 'null',
      'MaxPrice': maxPrice ?? 'null',
      'CategoryId': categoryId,
      'SellerType': sellerType ?? 'null',
      if (districtId == null)
        'DistrictId': 'null'
      else
        'DistrictId[]': districtId,
      if (cityId == null) 'CityId': 'null' else 'CityId[]': cityId,
      'MinTotalArea': minTotalArea ?? 'null',
      'MaxTotalArea': maxTotalArea ?? 'null',
      if (roomCount == null) 'RoomCount': 'null' else 'RoomCount[]': roomCount,
      if (bathroomCount == null)
        'BathroomCount': 'null'
      else
        'BathroomCount[]': bathroomCount,
      'Furnish': furnish ?? 'null',
      'OrderBy': orderBy ?? 'Price ASC',
      'Page': page ?? 0,
      'SearchTitle': searchTitle ?? 'null'
    };
  }
}
