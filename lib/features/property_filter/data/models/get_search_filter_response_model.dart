class GetSearchFilterResponseModel {
  final String status;
  final List<SearchFilterItemModel>? data;

  GetSearchFilterResponseModel({
    required this.status,
    required this.data,
  });

  factory GetSearchFilterResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return GetSearchFilterResponseModel(
      status: json['status'],
      data: rawData is Map<String, dynamic>
          ? rawData.values
              .map((item) => SearchFilterItemModel.fromJson(item))
              .toList()
          : null, // إذا كانت false أو null
    );
  }
}

class SearchFilterItemModel {
  final int searchId;
  final String searchTitle;
  final int clientId;
  final FilterContentModel content;
  final String date;

  SearchFilterItemModel({
    required this.searchId,
    required this.searchTitle,
    required this.clientId,
    required this.content,
    required this.date,
  });

  factory SearchFilterItemModel.fromJson(Map<String, dynamic> json) {
    return SearchFilterItemModel(
      searchId: json['SearchId'],
      searchTitle: json['SearchTitle'],
      clientId: json['ClientId'],
      content: FilterContentModel.fromJson(json['Content']),
      date: json['Date'],
    );
  }
}

class FilterContentModel {
  final List<int>? roomCount;
  final List<int>? cityId;
  final double? minPrice;
  final double? maxPrice;
  final int categoryId;
  final double? minTotalArea;
  final double? maxTotalArea;
  final List<int>? districtId;
  final List<int>? bathroomCount;
  final int? sellerType;

  FilterContentModel({
    this.roomCount,
    this.cityId,
    this.minPrice,
    this.maxPrice,
    required this.categoryId,
    this.minTotalArea,
    this.maxTotalArea,
    this.districtId,
    this.bathroomCount,
    this.sellerType,
  });

  factory FilterContentModel.fromJson(Map<String, dynamic> json) {
    return FilterContentModel(
      roomCount: (json['RoomCount'] as List?)?.map((e) => e as int).toList(),
      cityId: (json['CityId'] as List?)?.map((e) => e as int).toList(),
      minPrice: (json['MinPrice'] as num?)?.toDouble(),
      maxPrice: (json['MaxPrice'] as num?)?.toDouble(),
      categoryId: json['CategoryId'],
      minTotalArea: (json['MinTotalArea'] as num?)?.toDouble(),
      maxTotalArea: (json['MaxTotalArea'] as num?)?.toDouble(),
      districtId: (json['DistrictId'] as List?)?.map((e) => e as int).toList(),
      bathroomCount:
          (json['BathroomCount'] as List?)?.map((e) => e as int).toList(),
      sellerType: json['SellerType'],
    );
  }
}
