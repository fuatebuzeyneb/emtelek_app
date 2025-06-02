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
  final List<FeatureModel>? features;
  final List<ImageModel> images;
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
      features: json['Features'] is List
          ? (json['Features'] as List)
              .map((e) => FeatureModel.fromJson(e))
              .toList()
          : null,
      images: (json['Images'] as Map<String, dynamic>?)
              ?.values
              .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      data: PropertyData.fromJson(json['data'] ?? {}),
    );
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
      attachmentId: json['AttachmentId'] ?? 0,
      adId: json['AdId'] ?? 0,
      attachmentName: json['AttachmentName'] ?? '',
      isDeleted: json['IsDeleted'] ?? 0,
    );
  }
}

class PropertyData {
  final Client client;
  final City city;
  final District district;
  final Info info;

  PropertyData({
    required this.client,
    required this.city,
    required this.district,
    required this.info,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) {
    return PropertyData(
      client: Client.fromJson(json['client'] ?? {}),
      city: City.fromJson(json['city'] ?? {}),
      district: District.fromJson(json['district'] ?? {}),
      info: Info.fromJson(json['info'] ?? {}),
    );
  }
}

class Client {
  final int clientId;
  final String firstName;
  final String lastName;
  final dynamic phoneNumber;
  final String email;
  final String? image;
  final int verified;

  Client({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.verified,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientId: json['ClientId'] ?? 0,
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      phoneNumber: json['PhoneNumber'],
      email: json['Email'] ?? '',
      image: json['Image'],
      verified: json['Verified'] ?? 0,
    );
  }
}

class City {
  final int cityId;
  final String cityName;

  City({
    required this.cityId,
    required this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['CityId'] ?? 0,
      cityName: json['CityName'] ?? '',
    );
  }
}

class District {
  final int districtId;
  final int cityId;
  final String districtName;

  District({
    required this.districtId,
    required this.cityId,
    required this.districtName,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      districtId: json['DistrictId'] ?? 0,
      cityId: json['CityId'] ?? 0,
      districtName: json['DistrictName'] ?? '',
    );
  }
}

class Info {
  final int adId;
  final dynamic totalArea;
  final dynamic netArea;
  final dynamic roomCount;
  final dynamic floorNumber;
  final dynamic floorCount;
  final dynamic bathroomCount;
  final String furnish;
  final dynamic constructionDate;
  final String address;
  final dynamic balconyCount;
  final String complexName;

  Info({
    required this.adId,
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

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      adId: json['AdId'] ?? 0,
      totalArea: json['TotalArea'],
      netArea: json['NetArea'],
      roomCount: json['RoomCount'],
      floorNumber: json['FloorNumber'],
      floorCount: json['FloorCount'],
      bathroomCount: json['BathroomCount'],
      furnish: json['Furnish'] ?? '',
      constructionDate: json['ConstructionDate'],
      address: json['Address'] ?? '',
      balconyCount: json['BalconyCount'],
      complexName: json['ComplexName'] ?? '',
    );
  }
}
