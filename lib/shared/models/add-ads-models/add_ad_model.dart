import 'package:dio/dio.dart';

class AddAdModel {
  String? title;
  String? description;
  double? price;
  String? phone;
  String? currency;
  String? email;
  String? image;
  String? location;
  int? districtId;
  String? address;
  int clientId;
  int? sellerType;
  int? categoryId;
  String token;

  AddAdModel(
      {required this.title,
      required this.price,
      required this.location,
      required this.image,
      required this.description,
      required this.phone,
      required this.currency,
      required this.email,
      required this.districtId,
      required this.clientId,
      required this.sellerType,
      required this.categoryId,
      required this.token,
      required this.address});

  factory AddAdModel.fromJson(Map<String, dynamic> json) {
    return AddAdModel(
      title: json['Title'],
      price: json['Price'],
      location: json['Location'],
      image: json['Image'],
      description: json['Description'],
      phone: json['Phone'],
      currency: json['Currency'],
      email: json['Email'],
      districtId: json['DistrictId'],
      clientId: json['ClientId'] ?? 0,
      sellerType: json['SellerType'],
      categoryId: json['CategoryId'],
      token: json['Token'] ?? '',
      address: json['Address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AdTitle': title,
      'Price': price,
      'Location': location,
      //'Image': image,
      'Description': description,
      //  'Phone': phone,
      'Currency': currency,
      // 'Email': email,
      'DistrictId': districtId,
      'ClientId': clientId,
      'SellerType': sellerType,
      'CategoryId': categoryId,
      'Token': token,
      'Address': address
    };
  }

  @override
  String toString() {
    return 'AdModel('
        'title: $title, '
        'price: $price, '
        'location: $location, '
        'image: $image, '
        'description: $description, '
        'phone: $phone, '
        'currency: $currency, '
        'email: $email, '
        'districtId: $districtId, '
        'clientId: $clientId, '
        'sellerType: $sellerType, '
        'categoryId: $categoryId, '
        'token: $token)';
  }
}
