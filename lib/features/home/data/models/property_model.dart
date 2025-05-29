import 'package:emtelek/features/home/data/models/get_home_response_model.dart';

class Property {
  final int adId;
  final String adTitle;
  final int clientId;
  final int categoryId;
  final int districtId;
  final dynamic price;
  final String currency;
  final int sellerType;
  final String publishDate;
  final String description;
  final String location;
  final String mainImage;
  final int status;
  bool? isFavorite;
  final dynamic features;
  final Map<String, ImageModel> images;
  final PropertyData data;

  Property({
    required this.adId,
    required this.adTitle,
    required this.clientId,
    required this.categoryId,
    required this.districtId,
    required this.price,
    required this.currency,
    required this.sellerType,
    required this.publishDate,
    required this.description,
    required this.location,
    required this.mainImage,
    required this.status,
    required this.isFavorite,
    required this.features,
    required this.images,
    required this.data,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      adId: json['AdId'] ?? 0,
      adTitle: json['AdTitle'] ?? '',
      clientId: json['ClientId'] ?? 0,
      categoryId: json['CategoryId'] ?? 0,
      districtId: json['DistrictId'] ?? 0,
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      currency: json['Currency'] ?? '',
      sellerType: json['SellerType'] ?? 0,
      publishDate: json['PublishDate'] ?? '',
      description: json['Description'] ?? '',
      location: json['Location'] ?? '',
      mainImage: json['MainImage'] ?? '',
      status: json['Status'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      features: json['Features'],
      images: (json['Images'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              ImageModel.fromJson(value as Map<String, dynamic>),
            ),
          ) ??
          {},
      data: PropertyData.fromJson(json['data'] ?? {}),
    );
  }
}
