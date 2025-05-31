class AddPropertyAdRequestModel {
  final String token;
  final int clientId;
  final String adTitle;
  final int categoryId;
  final int districtId;
  final double price;
  final String currency;
  final int sellerType;
  final String location;
  final int totalArea;
  final int roomCount;
  final int bathroomCount;
  final int phoneNumber;
  final String? description;
  final int? netArea;
  final String? address;
  final int? floorCount;
  final String? furnish;
  final String? constructionDate;
  final String? complexName;

  final int? floorNumber;
  final int? balconyCount;

  AddPropertyAdRequestModel({
    required this.token,
    required this.clientId,
    required this.adTitle,
    required this.categoryId,
    required this.districtId,
    required this.price,
    required this.currency,
    required this.sellerType,
    required this.location,
    required this.totalArea,
    required this.roomCount,
    required this.bathroomCount,
    required this.phoneNumber,
    this.description,
    this.netArea,
    this.address,
    this.floorCount,
    this.furnish,
    this.constructionDate,
    this.complexName,
    this.floorNumber,
    this.balconyCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'Token': token,
      'ClientId': clientId,
      'AdTitle': adTitle,
      'CategoryId': categoryId,
      'DistrictId': districtId,
      'Price': price,
      'Currency': currency,
      'SellerType': sellerType,
      'PhoneNumber': phoneNumber,
      'Location': location,
      'TotalArea': totalArea,
      'RoomCount': roomCount,
      'BathroomCount': bathroomCount,
      'Description': description,
      'NetArea': netArea,
      'Address': address,
      'FloorCount': floorCount,
      'Furnish': furnish,
      'ConstructionDate': constructionDate,
      'ComplexName': complexName,
      'FloorNumber': floorNumber,
      'BalconyCount': balconyCount,
    };
  }
}
