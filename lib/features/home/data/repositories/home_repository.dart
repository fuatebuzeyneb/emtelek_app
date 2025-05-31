import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/home/data/models/get_home_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/home/data/models/search_request_model.dart';
import 'package:emtelek/features/home/data/models/search_response_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

abstract class HomeRepository {
  Future<GetHomeResponseModel> getHomeAds(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});
  Future<SearchResponseModel> getSearchAds({
    required SearchRequestModel searchRequestModel,
  });
}

class HomeRepositoryImpl implements HomeRepository {
  final ApiConsumer api;

  HomeRepositoryImpl({required this.api});

  @override
  Future<GetHomeResponseModel> getHomeAds(
      {required TokenAndClintIdRequestModel
          tokenAndClintIdRequestModel}) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsHome}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );

    return GetHomeResponseModel.fromJson(response);
  }

  @override
  Future<SearchResponseModel> getSearchAds({
    required SearchRequestModel searchRequestModel,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.adsSearch}',
      isFormData: true,
      data: searchRequestModel.toJson(),
    );

    return SearchResponseModel.fromJson(response);
  }
}
