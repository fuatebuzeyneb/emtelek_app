class EditUserResponseModel {
  final String status;
  final String token;
  final UserData data;
  final AddressData? addressData;

  EditUserResponseModel({
    required this.status,
    required this.token,
    required this.data,
    this.addressData,
  });

  factory EditUserResponseModel.fromJson(Map<String, dynamic> json) {
    return EditUserResponseModel(
      status: json['status'] as String,
      token: json['token'] as String,
      data: UserData.fromJson(json['data']),
      addressData: json['address_data'] != null && json['address_data'] is Map
          ? AddressData.fromJson(json['address_data'])
          : null,
    );
  }
}

class UserData {
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

  UserData({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.subscriptionDate,
    required this.status,
    required this.accountType,
    this.image,
    required this.verified,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      clientId: json['ClientId'] as int,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      phoneNumber: json['PhoneNumber'] as String,
      email: json['Email'] as String,
      password: json['Password'] as String,
      subscriptionDate: json['SubscriptionDate'] as String,
      status: json['Status'] as int,
      accountType: json['AccountType'] as int,
      image: json['Image'],
      verified: json['Verified'] as int,
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
