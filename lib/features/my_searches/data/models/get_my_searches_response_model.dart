class GetMySearchesResponseModel {
  final String status;
  final List<SearchFilterItemModel>? data;

  GetMySearchesResponseModel({
    required this.status,
    required this.data,
  });

  factory GetMySearchesResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    return GetMySearchesResponseModel(
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
    List<int>? parseIntList(dynamic list) {
      if (list is List &&
          list.every(
              (e) => e is int || (e is String && int.tryParse(e) != null))) {
        return list.map((e) => e is int ? e : int.parse(e)).toList();
      }
      return null;
    }

    double? parseDouble(dynamic value) {
      if (value == null || value == "null") return null;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    int? parseInt(dynamic value) {
      if (value == null || value == "null") return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    dynamic normalizeList(dynamic value) {
      if (value == null || value == "null") return null;
      return value;
    }

    return FilterContentModel(
      roomCount: parseIntList(normalizeList(json['RoomCount'])),
      cityId: parseIntList(normalizeList(json['CityId'])),
      minPrice: parseDouble(json['MinPrice']),
      maxPrice: parseDouble(json['MaxPrice']),
      categoryId: parseInt(json['CategoryId']) ?? 0, // لأنه required
      minTotalArea: parseDouble(json['MinTotalArea']),
      maxTotalArea: parseDouble(json['MaxTotalArea']),
      districtId: parseIntList(normalizeList(json['DistrictId'])),
      bathroomCount: parseIntList(normalizeList(json['BathroomCount'])),
      sellerType: parseInt(json['SellerType']),
    );
  }
}
