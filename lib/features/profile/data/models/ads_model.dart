class AdsModel {
  String token;
  int adId;
  String adTitle;
  dynamic price;
  String currency;
  String? description;
  String location;
  String publishDate;
  int status;
  int categoryId;
  int? sellerType;
  int clientId;
  String firstName;
  String lastName;
  String phoneNumber;
  String? email;
  String? subscriptionDate;
  int? cityId;
  String? cityName;
  int? districtId;
  int? districtCityId;
  String? districtName;
  dynamic totalArea;
  dynamic netOrBuildingArea;
  int? roomCount;
  int? floorNumber;
  dynamic floorCount;
  int? bathroomCount;
  dynamic furnish;
  String? constructionDate;
  String? address;
  int? balconyCount;
  String? complexName;
  bool? isFinished;

  AdsModel({
    required this.token,
    required this.adId,
    required this.adTitle,
    required this.price,
    required this.currency,
    this.description,
    required this.location,
    required this.publishDate,
    required this.status,
    required this.sellerType,
    required this.categoryId,
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.subscriptionDate,
    this.cityId,
    this.cityName,
    this.districtId,
    this.districtCityId,
    this.districtName,
    required this.totalArea,
    this.netOrBuildingArea,
    this.roomCount,
    this.floorNumber,
    this.floorCount,
    this.bathroomCount,
    this.furnish,
    this.constructionDate,
    this.address,
    this.balconyCount,
    this.complexName,
    this.isFinished,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      token: json['Token'] ?? '',
      adId: json['AdId'],
      adTitle: json['AdTitle'] ?? '',
      price: (json['Price'] is String)
          ? double.tryParse(json['Price']) ?? 0.0
          : json['Price']?.toDouble() ?? 0.0,
      currency: json['Currency'] ?? '',
      description: json['Description'] ?? '',
      location: json['Location'] ?? '',
      publishDate: json['PublishDate'] ?? '',
      status: (json['Status'] is String)
          ? int.tryParse(json['Status']) ?? 0
          : json['Status'] ?? 0,
      sellerType: (json['SellerType'] is String)
          ? int.tryParse(json['SellerType']) ?? 0
          : json['SellerType'] ?? 0,
      categoryId: (json['CategoryId'] is String)
          ? int.tryParse(json['CategoryId']) ?? 0
          : json['CategoryId'] ?? 0,
      clientId: json['data']['client']['ClientId'],
      firstName: json['data']['client']['FirstName'],
      lastName: json['data']['client']['LastName'],
      phoneNumber: json['data']['client']['PhoneNumber'] ?? '',
      email: json['data']['client']['Email'] ?? '',
      subscriptionDate: json['data']['client']['SubscriptionDate'] ?? '',
      cityId: json['data']['city']['CityId'],
      cityName: json['data']['city']['CityName'],
      districtId: json['data']['district']['DistrictId'],
      districtCityId: json['data']['district']['CityId'],
      districtName: json['data']['district']['DistrictName'],
      totalArea: json['data']['info']['TotalArea'] ?? "",
      netOrBuildingArea: json['data']['info']['NetArea'] ?? '',
      roomCount: json['data']['info']['RoomCount'] ?? 0,
      floorNumber: json['data']['info']['FloorNumber'] ?? 0,
      floorCount: json['data']['info']['FloorCount'] ?? '',
      bathroomCount: json['data']['info']['BathroomCount'] ?? 0,
      furnish: json['data']['info']['Furnish'],
      constructionDate: json['data']['info']['ConstructionDate'] ?? '',
      address: json['data']['info']['Address'] ?? '',
      balconyCount: json['data']['info']['BalconyCount'] ?? 0,
      complexName: json['data']['info']['ComplexName'] ?? '',
      isFinished: json['IsFinished'] ?? true,
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'Token': token,
      'AdId': adId,
      'AdTitle': adTitle,
      'Price': price,
      'Currency': currency,
      'Description': description,
      'Location': location,
      'PublishDate': publishDate,
      'Status': status,
      'SellerType': sellerType,
      'CategoryId': categoryId,
      'ClientId': clientId,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'SubscriptionDate': subscriptionDate,
      'CityId': cityId,
      'CityName': cityName,
      'DistrictId': districtId,
      'DistrictCityId': districtCityId,
      'DistrictName': districtName,
      'TotalArea': totalArea,
      'NetArea': netOrBuildingArea,
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
