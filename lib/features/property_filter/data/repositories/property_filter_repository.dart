import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/home/data/models/search_request_model.dart';
import 'package:emtelek/features/property/data/models/property_filter_request_mode.dart';
import 'package:emtelek/features/property_filter/data/models/property_filter_response_model.dart';

abstract class PropertyFilterRepository {
  Future<PropertyFilterResponseModel> getFilterAds({
    required PropertyFilterRequestModel propertyFilterRequestModel,
  });
}

class PropertyFilterRepositoryImpl implements PropertyFilterRepository {
  final ApiConsumer api;

  PropertyFilterRepositoryImpl({required this.api});

  @override
  Future<PropertyFilterResponseModel> getFilterAds(
      {required PropertyFilterRequestModel propertyFilterRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsFilter}',
      isFormData: true,
      data: propertyFilterRequestModel.toJson(),
    );

    return PropertyFilterResponseModel.fromJson(response);
  }

  // Future<SearchResponseModel> getSearchAds({
  //   required SearchRequestModel searchRequestModel,
  // }) async {
  //   final response = await api.post(
  //     '${EndPoints.baseUrl}${EndPoints.adsSearch}',
  //     isFormData: true,
  //     data: searchRequestModel.toJson(),
  //   );

  //   return SearchResponseModel.fromJson(response);
  // }
}
