import 'package:emtelek/features/property/data/models/get_save_search_model.dart';

class PropertyFilterRequestModel {
  final String? token;
  final dynamic clientId;
  final dynamic minPrice;
  final dynamic maxPrice;
  final dynamic categoryId;
  final dynamic sellerType;
  final List<int>? districtId;
  final List<int>? cityId;
  final dynamic minTotalArea;
  final dynamic maxTotalArea;
  final List<int>? roomCount;
  final List<int>? bathroomCount;
  final dynamic furnish;
  final dynamic page;
  final String? orderBy;
  final String? searchTitle;
  final ContentModel? content;

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
      this.content,
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

  factory PropertyFilterRequestModel.fromJson(Map<String, dynamic> json) {
    final content = json['Content'];

    return PropertyFilterRequestModel(
      searchTitle: json['SearchTitle'] as String? ?? '',
      content: content is Map<String, dynamic>
          ? ContentModel.fromJson(content)
          : null,
      token: '',
      clientId: null,
      minPrice: null,
      maxPrice: null,
      categoryId: null,
      sellerType: null,
      districtId: [],
      cityId: [],
      minTotalArea: null,
      maxTotalArea: null,
      roomCount: [],
      bathroomCount: [],
      furnish: null,
      orderBy: '',
      page: null,
    );
  }
}
