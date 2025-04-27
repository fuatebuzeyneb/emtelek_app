import 'package:emtelek/features/profile/data/models/account_data_model.dart';
import 'package:emtelek/features/profile/data/models/address_data_model.dart';

class AccountResponseModel {
  final String? status;
  final String? token;
  final AccountDataModel? data;
  final AddressDataModel? addressData;

  AccountResponseModel({
    this.status,
    this.token,
    this.data,
    this.addressData,
  });

  factory AccountResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountResponseModel(
      status: json['status'],
      token: json['token'],
      data:
          json['data'] != null ? AccountDataModel.fromJson(json['data']) : null,
      addressData: json['address_data'] is Map<String, dynamic>
          ? AddressDataModel.fromJson(json['address_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'token': token,
      'data': data?.toJson(),
      'address_data': addressData?.toJson(),
    };
  }
}
