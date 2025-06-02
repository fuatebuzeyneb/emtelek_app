import 'package:emtelek/features/home/data/models/property_model.dart';

class PropertyFilterResponseModel {
  final String? status;
  final bool? isFinished;
  final List<Property>? data;

  PropertyFilterResponseModel({
    this.status,
    this.isFinished,
    this.data,
  });

  factory PropertyFilterResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    List<Property> parsedData = [];

    if (rawData is Map<String, dynamic>) {
      parsedData = rawData.values
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return PropertyFilterResponseModel(
      status: json['status'],
      isFinished: json['isFinished'],
      data: parsedData,
    );
  }
}
