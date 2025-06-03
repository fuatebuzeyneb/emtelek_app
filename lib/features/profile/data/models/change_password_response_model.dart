// File: change_password_response_model.dart

class ChangePasswordResponseModel {
  final String status;
  final String token;
  final ClientData data;
  final AddressData? addressData; // اختياري

  ChangePasswordResponseModel({
    required this.status,
    required this.token,
    required this.data,
    this.addressData,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      status: json['status'],
      token: json['token'],
      data: ClientData.fromJson(json['data']),
      addressData: (json['address_data'] is Map<String, dynamic>)
          ? AddressData.fromJson(json['address_data'])
          : null, // إذا جاء false أو غير خريطة نضع null
    );
  }
}

class ClientData {
  final int clientId;
  final String firstName;
  final String lastName;
  final int phoneNumber;
  final String email;
  final String password;
  final String subscriptionDate;
  final int status;
  final int accountType;
  final String image;
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
}
