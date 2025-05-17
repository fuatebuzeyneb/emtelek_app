class GetUserResponseModel {
  final String status;
  final String token;
  final ClientData data;
  final AddressData? addressData;

  GetUserResponseModel({
    required this.status,
    required this.token,
    required this.data,
    this.addressData,
  });

  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) {
    return GetUserResponseModel(
      status: json['status'],
      token: json['token'],
      data: ClientData.fromJson(json['data']),
      addressData: json['address_data'] is Map<String, dynamic>
          ? AddressData.fromJson(json['address_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'token': token,
      'data': data.toJson(),
      'address_data': addressData?.toJson(),
    };
  }
}

class ClientData {
  final int clientId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String subscriptionDate;
  final int status;
  final int accountType;
  final String? image;
  final int verified;

  ClientData({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.subscriptionDate,
    required this.status,
    required this.accountType,
    required this.image,
    required this.verified,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      clientId: json['ClientId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      phoneNumber: json['PhoneNumber'],
      email: json['Email'],
      password: json['Password'],
      subscriptionDate: json['SubscriptionDate'],
      status: json['Status'],
      accountType: json['AccountType'],
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
      'Password': password,
      'SubscriptionDate': subscriptionDate,
      'Status': status,
      'AccountType': accountType,
      'Image': image,
      'Verified': verified,
    };
  }
}

class AddressData {
  final int clientId;
  final int districtId;
  final String address;

  AddressData({
    required this.clientId,
    required this.districtId,
    required this.address,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      clientId: json['ClientId'],
      districtId: json['DistrictId'],
      address: json['Address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ClientId': clientId,
      'DistrictId': districtId,
      'Address': address,
    };
  }
}
