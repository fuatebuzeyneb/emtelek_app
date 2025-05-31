import 'package:emtelek/features/home/data/models/property_model.dart';

class SearchResponseModel {
  final String status;
  final bool isFinished;
  final List<Property> data;
  final bool hasData;

  SearchResponseModel({
    required this.status,
    required this.isFinished,
    required this.data,
    required this.hasData,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<Property> properties = [];

    bool hasData = false;

    if (rawData is Map<String, dynamic>) {
      hasData = true;
      properties = rawData.values
          .map((item) => Property.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return SearchResponseModel(
      status: json['status'] ?? '',
      isFinished: json['isFinished'] ?? false,
      data: properties,
      hasData: hasData,
    );
  }
}
