class AdModelX {
  int adId;
  int categoryId;
  int status;
  String adTitle;
  String price;
  String currency;
  String description;
  String location;
  String mainImage;
  String publishDate;
  List<ImageModel> images;
  ClientModel client;
  CityModel city;
  DistrictModel district;
  PropertyInfoModel propertyInfo;

  AdModelX({
    required this.adId,
    required this.adTitle,
    required this.price,
    required this.currency,
    required this.description,
    required this.location,
    required this.mainImage,
    required this.images,
    required this.client,
    required this.city,
    required this.district,
    required this.propertyInfo,
    required this.categoryId,
    required this.publishDate,
    required this.status,
  });

  factory AdModelX.fromJson(Map<String, dynamic> json) => AdModelX(
        adId: json['AdId'],
        categoryId: json['CategoryId'],
        adTitle: json['AdTitle'],
        price: json['Price'],
        currency: json['Currency'],
        description: json['Description'],
        location: json['Location'],
        mainImage: json['MainImage'],
        images: (json['Images'] as Map<String, dynamic>)
            .values
            .map((e) => ImageModel.fromJson(e))
            .toList(),
        client: ClientModel.fromJson(json['Client']),
        city: CityModel.fromJson(json['City']),
        district: DistrictModel.fromJson(json['District']),
        propertyInfo: PropertyInfoModel.fromJson(json['info']),
        publishDate: json['PublishDate'],
        status: json['Status'],
      );

  Map<String, dynamic> toJson() => {
        'AdId': adId,
        'AdTitle': adTitle,
        'Price': price,
        'Currency': currency,
        'Description': description,
        'Location': location,
        'MainImage': mainImage,
        'Images': images.map((e) => e.toJson()).toList(),
        'Client': client.toJson(),
        'City': city.toJson(),
        'District': district.toJson(),
        'info': propertyInfo.toJson(),
      };
}

class ImageModel {
  int id;
  String imageUrl;

  ImageModel({required this.id, required this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json['Id'],
        imageUrl: json['ImageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'ImageUrl': imageUrl,
      };
}

class ClientModel {
  int id;
  String name;
  String email;

  ClientModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json['Id'],
        name: json['Name'],
        email: json['Email'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Email': email,
      };
}

class CityModel {
  int id;
  String name;

  CityModel({
    required this.id,
    required this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['Id'],
        name: json['Name'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
      };
}

class DistrictModel {
  int id;
  String name;

  DistrictModel({
    required this.id,
    required this.name,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        id: json['Id'],
        name: json['Name'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
      };
}

class PropertyInfoModel {
  int rooms;
  double area;
  int floor;

  PropertyInfoModel({
    required this.rooms,
    required this.area,
    required this.floor,
  });

  factory PropertyInfoModel.fromJson(Map<String, dynamic> json) =>
      PropertyInfoModel(
        rooms: json['Rooms'],
        area: (json['Area'] as num).toDouble(),
        floor: json['Floor'],
      );

  Map<String, dynamic> toJson() => {
        'Rooms': rooms,
        'Area': area,
        'Floor': floor,
      };
}
