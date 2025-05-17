import 'dart:io';

import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

class EditUserRequestModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String image;
  final int districtId;
  final String address;

  EditUserRequestModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.districtId,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'ClientId': getIt<CacheHelper>().getData(key: 'clientId'),
      'Token': getIt<CacheHelper>().getDataString(key: 'token'),
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Image': image,
      'DistrictId': districtId,
      'Address': address,
    };
  }

  @override
  String toString() {
    return 'EditUserRequestModel(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, image: $image, districtId: $districtId, address: $address)';
  }
}
