class ClientsResponseModel {
  ClientsResponseModel({
    required this.status,
    required this.token,
    required this.data,
    required this.addressData,
  });

  final String? status;
  final String? token;
  final Data? data;
  final AddressData? addressData;

  factory ClientsResponseModel.fromJson(Map<String, dynamic> json) {
    return ClientsResponseModel(
      status: json["status"],
      token: json["token"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      addressData: _parseAddressData(json["address_data"]),
    );
  }

  // دالة تساعد في التحقق مما إذا كان `addressData` كائنًا صحيحًا أم لا
  static AddressData? _parseAddressData(dynamic json) {
    if (json == null) {
      return null;
    } else if (json is Map<String, dynamic>) {
      return AddressData.fromJson(json);
    } else {
      print("Warning: Unexpected addressData format: $json");
      return null;
    }
  }
}

class AddressData {
  AddressData({
    required this.clientId,
    required this.districtId,
    required this.address,
  });

  final int? clientId;
  final int? districtId;
  final String? address;

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      clientId: json["ClientId"],
      districtId: json["DistrictId"],
      address: json["Address"],
    );
  }
}

class Data {
  Data({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.subscriptionDate,
    required this.status,
    required this.accountType,
  });

  final int? clientId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final DateTime? subscriptionDate;
  final int? status;
  final int? accountType;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      clientId: json["ClientId"],
      firstName: json["FirstName"],
      lastName: json["LastName"],
      phoneNumber: json["PhoneNumber"],
      email: json["Email"],
      password: json["Password"],
      subscriptionDate: json["SubscriptionDate"] != null
          ? DateTime.tryParse(json["SubscriptionDate"] ?? "")
          : null,
      status: json["Status"],
      accountType: json["AccountType"],
    );
  }
}

void printClientDetails(ClientsResponseModel client) {
  print("🔹🔹🔹 Client Response Details 🔹🔹🔹");
  print("Status: ${client.status}");
  print("Token: ${client.token}");
  print("--------------------------------------------------");

  // طباعة بيانات العميل
  if (client.data != null) {
    print("👤 Client Details:");
    print("- ID: ${client.data!.clientId}");
    print("- Name: ${client.data!.firstName} ${client.data!.lastName}");
    print("- Phone Number: ${client.data!.phoneNumber}");
    print("- Email: ${client.data!.email}");
    print("- Status: ${client.data!.status}");
    print("- Subscription Date: ${client.data!.subscriptionDate}");
  } else {
    print("⚠️ No client data available.");
  }
  print("--------------------------------------------------");

  // طباعة بيانات العنوان
  if (client.addressData != null) {
    if (client.addressData is AddressData) {
      final address = client.addressData as AddressData;
      print("🏠 Address Data:");
      print("- Client ID: ${address.clientId}");
      print("- District ID: ${address.districtId}");
      print("- Address: ${address.address}");
    } else {
      print("📍 Address Data (Raw): ${client.addressData}");
    }
  } else {
    print("⚠️ No address data available.");
  }
  print("🔹🔹🔹 End of Client Details 🔹🔹🔹");
}
