import 'package:emtelek/features/home/data/models/property_model.dart';

class GetHomeResponseModel {
  final String status;
  final int carbrandsCount;
  final int districtsCount;
  final List<Property>? propertiesRent;
  final List<Property>? propertiesSell;
  final List<Property>? vehicles;

  GetHomeResponseModel({
    required this.status,
    required this.carbrandsCount,
    required this.districtsCount,
    required this.propertiesRent,
    required this.propertiesSell,
    required this.vehicles,
  });

  factory GetHomeResponseModel.fromJson(Map<String, dynamic> json) {
    final rentRaw = json['properties_rent'];
    final sellRaw = json['properties_sell'];
    final vehiclesRaw = json['vehicles'];

    return GetHomeResponseModel(
      status: json['status'] ?? '',
      carbrandsCount: json['carbrands_count'] ?? 0,
      districtsCount: json['districts_count'] ?? 0,
      propertiesRent: rentRaw is List
          ? rentRaw.map((e) => Property.fromJson(e)).toList()
          : rentRaw is Map
              ? rentRaw.values.map((e) => Property.fromJson(e)).toList()
              : [],
      propertiesSell: sellRaw is List
          ? sellRaw.map((e) => Property.fromJson(e)).toList()
          : sellRaw is Map
              ? sellRaw.values.map((e) => Property.fromJson(e)).toList()
              : [],
      vehicles: vehiclesRaw is List
          ? vehiclesRaw.map((e) => Property.fromJson(e)).toList()
          : vehiclesRaw is Map
              ? vehiclesRaw.values.map((e) => Property.fromJson(e)).toList()
              : [],
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
