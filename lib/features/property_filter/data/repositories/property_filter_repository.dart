import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';

import 'package:emtelek/features/property_filter/data/models/get_search_filter_response_model.dart';
import 'package:emtelek/features/property_filter/data/models/property_filter_request_model.dart';
import 'package:emtelek/features/property_filter/data/models/property_filter_response_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';

abstract class PropertyFilterRepository {
  Future<PropertyFilterResponseModel> getFilterAds({
    required PropertyFilterRequestModel propertyFilterRequestModel,
  });

  Future<GetSearchFilterResponseModel> getSavedFilterSearchAds({
    required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
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

  @override
  Future<GetSearchFilterResponseModel> getSavedFilterSearchAds({
    required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientSearchesGet}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );

    return GetSearchFilterResponseModel.fromJson(response);
  }
}
