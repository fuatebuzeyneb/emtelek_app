class SaveSearchFilterRequestModel {
  final int clintId;
  final String token;
  final String filterName;
  final List<int>? roomCount;
  final List<int>? bathroomCount;
  final List<int>? cityId;
  final double? minPrice;
  final double? maxPrice;
  final int categoryId;
  final int? sellerType;
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
    this.bathroomCount,
    this.sellerType,
    required this.filterName,
    required this.clintId,
    required this.token,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'ClintId': clintId,
      'Token': token,
      'SearchTitle': filterName,
      'CategoryId': categoryId,
      'MinPrice': minPrice,
      'MaxPrice': maxPrice,
      'MinTotalArea': minTotalArea,
      'MaxTotalArea': maxTotalArea,
      'Furnish': furnish,
      "SellerType": sellerType
    };

    // roomCount
    if (roomCount != null && roomCount!.isNotEmpty) {
      data['RoomCount[]'] = roomCount;
    } else {
      data['RoomCount'] = null;
    }

    // bathroomCount
    if (bathroomCount != null && bathroomCount!.isNotEmpty) {
      data['BathroomCount[]'] = bathroomCount;
    } else {
      data['BathroomCount'] = null;
    }

    // cityId
    if (cityId != null && cityId!.isNotEmpty) {
      data['CityId[]'] = cityId;
    } else {
      data['CityId'] = null;
    }

    // districtId
    if (districtId != null && districtId!.isNotEmpty) {
      data['DistrictId[]'] = districtId;
    } else {
      data['DistrictId'] = null;
    }

    return data;
  }
}
