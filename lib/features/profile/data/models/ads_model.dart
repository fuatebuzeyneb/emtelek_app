import 'package:emtelek/features/profile/data/models/featur_model.dart';

class AdModel {
  String? token;
  int? adId;
  String? adTitle;
  int? clientId;
  int? categoryId;
  String? price;
  String? currency;
  int? sellerType;
  String? publishDate;
  String? description;
  String? location;
  int? status;
  bool? isFavorite;
  List<FeatureModel>? features;
  List<int>? featureIds;
  List<ImageModel>? images;
  String? mainImage;
  ClientModel client;
  CityModel? city;
  DistrictModel district;
  AdInfoModel info;

  AdModel({
    required this.token,
    required this.adId,
    required this.adTitle,
    required this.clientId,
    required this.categoryId,
    required this.price,
    required this.currency,
    required this.sellerType,
    this.featureIds,
    this.publishDate,
    required this.description,
    required this.location,
    this.status,
    this.isFavorite,
    this.features,
    this.images,
    required this.client,
    this.city,
    required this.district,
    required this.info,
    this.mainImage,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AdModel(
      token: '',
      adId: json['AdId'],
      adTitle: json['AdTitle'],
      clientId: json['ClientId'],
      categoryId: json['CategoryId'],
      price: json['Price'],
      currency: json['Currency'],
      sellerType: json['SellerType'],
      publishDate: json['PublishDate'],
      description: json['Description'] ?? '',
      location: json['Location'],
      status: json['Status'],
      mainImage: json['MainImage'],
      isFavorite: json['isFavorite'],
      features: (json['Features'] is List)
          ? (json['Features'] as List<dynamic>)
              .map((featureJson) => FeatureModel.fromJson(featureJson))
              .toList()
          : [],
      images: (json['Images'] as Map)
          .values
          .map((e) => ImageModel.fromJson(e))
          .toList(),
      client: ClientModel.fromJson(data['client']),
      city: CityModel.fromJson(data['city']),
      district: DistrictModel.fromJson(data['district']),
      info: AdInfoModel.fromJson(data['info']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Token': token,
      'AdTitle': adTitle,
      'ClientId': clientId,
      'CategoryId': categoryId,
      'Price': price,
      'Currency': currency,
      'SellerType': sellerType,
      //'PublishDate': publishDate,
      'Description': description,
      'Location': location,
      //'MainImage': mainImage,
      if (featureIds!.isEmpty || featureIds == null)
        'Features': 'null'
      else
        'Features[]': featureIds,

      /// 'Images': images,
      ...district.toJson(),
      ...info.toJson(),
    };
  }
}

class AdInfoModel {
  int? adId;
  String? totalArea;
  String? netArea;
  int? roomCount;
  int? floorNumber;
  int? floorCount;
  int? bathroomCount;
  bool? furnish;
  String? constructionDate;
  String? address;
  int? balconyCount;
  String? complexName;

  AdInfoModel({
    this.adId,
    required this.totalArea,
    required this.netArea,
    required this.roomCount,
    required this.floorNumber,
    required this.floorCount,
    required this.bathroomCount,
    required this.furnish,
    required this.constructionDate,
    required this.address,
    required this.balconyCount,
    required this.complexName,
  });

  factory AdInfoModel.fromJson(Map<String, dynamic> json) {
    return AdInfoModel(
      adId: json['AdId'],
      totalArea: (json['TotalArea'] ?? '').toString(),
      netArea: (json['NetArea'] ?? '').toString(),
      roomCount: json['RoomCount'],
      floorNumber: json['FloorNumber'],
      floorCount: json['FloorCount'],
      bathroomCount: json['BathroomCount'],
      furnish: json['Furnish']?.toString().toLowerCase() == 'yes',
      constructionDate: json['ConstructionDate'] ?? '',
      address: json['Address'] ?? '',
      balconyCount: json['BalconyCount'],
      complexName: json['ComplexName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'AdId': adId,
      'TotalArea': totalArea,
      'NetArea': netArea,
      'RoomCount': roomCount,
      'FloorNumber': floorNumber,
      'FloorCount': floorCount,
      'BathroomCount': bathroomCount,
      'Furnish': furnish,
      'ConstructionDate': constructionDate,
      'Address': address,
      'BalconyCount': balconyCount,
      'ComplexName': complexName,
    };
  }
}

class CityModel {
  final int cityId;
  final String cityName;

  CityModel({required this.cityId, required this.cityName});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['CityId'],
      cityName: json['CityName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CityId': cityId,
      'CityName': cityName,
    };
  }
}

class ClientModel {
  int? clientId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? subscriptionDate;
  String? image;
  int? verified;

  ClientModel({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.subscriptionDate,
    required this.image,
    required this.verified,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clientId: json['ClientId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      phoneNumber: json['PhoneNumber'],
      email: json['Email'],
      subscriptionDate: json['SubscriptionDate'],
      image: json['Image'],
      verified: json['Verified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ClientId': clientId,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'SubscriptionDate': subscriptionDate,
      'Image': image,
      'Verified': verified,
    };
  }
}

class FeatureModel {
  final int featureId;
  final String featureName;
  final String featureIcon;

  FeatureModel({
    required this.featureId,
    required this.featureName,
    required this.featureIcon,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      featureId: json['FeatureId'],
      featureName: json['FeatureName'],
      featureIcon: json['FeatureIcon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FeatureId': featureId,
      'FeatureName': featureName,
      'FeatureIcon': featureIcon,
    };
  }
}

class ImageModel {
  final int attachmentId;
  final int adId;
  final String attachmentName;
  final int isDeleted;

  ImageModel({
    required this.attachmentId,
    required this.adId,
    required this.attachmentName,
    required this.isDeleted,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      attachmentId: json['AttachmentId'],
      adId: json['AdId'],
      attachmentName: json['AttachmentName'],
      isDeleted: json['IsDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AttachmentId': attachmentId,
      'AdId': adId,
      'AttachmentName': attachmentName,
      'IsDeleted': isDeleted,
    };
  }
}

class DistrictModel {
  int? districtId;
  int? cityId;
  String? districtName;

  DistrictModel({
    required this.districtId,
    this.cityId,
    this.districtName,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      districtId: json['DistrictId'],
      cityId: json['CityId'],
      districtName: json['DistrictName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DistrictId': districtId,
      // 'CityId': cityId,
      // 'DistrictName': districtName,
    };
  }
}
