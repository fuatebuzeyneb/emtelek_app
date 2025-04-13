class PropertyFilterRequestModel {
  final String? token;
  final int? clientId;
  final int? minPrice;
  final int? maxPrice;
  final int? categoryId;
  final int? sellerType;
  final List<int>? districtId;
  final List<int>? cityId;
  final int? minTotalArea;
  final int? maxTotalArea;
  final List<int>? roomCount;
  final List<int>? bathroomCount;
  final dynamic furnish;
  final int? page;
  final String? orderBy;
  final String? searchTitle;

  PropertyFilterRequestModel(
      {required this.token,
      required this.clientId,
      required this.minPrice,
      required this.maxPrice,
      required this.categoryId,
      required this.sellerType,
      required this.districtId,
      required this.cityId,
      required this.minTotalArea,
      required this.maxTotalArea,
      required this.roomCount,
      required this.bathroomCount,
      required this.furnish,
      required this.orderBy,
      required this.searchTitle,
      required this.page});
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
