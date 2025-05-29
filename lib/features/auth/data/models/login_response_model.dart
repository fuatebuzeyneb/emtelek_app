class LoginResponseModel {
  final String status;
  final String token;
  final ClientData data;
  final AddressData? addressData;

  LoginResponseModel({
    required this.status,
    required this.token,
    required this.data,
    this.addressData,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] as String,
      token: json['token'] as String,
      data: ClientData.fromJson(json['data']),
      addressData: json['address_data'] is Map<String, dynamic>
          ? AddressData.fromJson(json['address_data'])
          : null,
    );
  }
}

class ClientData {
  final int clientId;
  final String firstName;
  final String lastName;
  final int phoneNumber;
  final String email;
  final String subscriptionDate;
  final int status;

  ClientData({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.subscriptionDate,
    required this.status,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      clientId: json['ClientId'] as int,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      phoneNumber: json['PhoneNumber'] as int,
      email: json['Email'] as String,
      subscriptionDate: json['SubscriptionDate'] as String,
      status: json['Status'] as int,
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
      clientId: json['ClientId'] as int,
      districtId: json['DistrictId'] as int,
      address: json['Address'] as String,
    );
  }
}
