import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/my_searches/data/models/delete_one_my_search_request_model.dart';
import 'package:emtelek/features/my_searches/data/models/get_my_searches_response_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';

abstract class MySearchesRepository {
  Future<GetMySearchesResponseModel> getMySearches({
    required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
  });

  Future<void> deleteOneMySearch({
    required DeleteOneMySearchRequestModel deleteOneMySearchRequestModel,
  });
}

class MySearchesRepositoryImpl implements MySearchesRepository {
  final ApiConsumer api;

  MySearchesRepositoryImpl({required this.api});

  @override
  Future<GetMySearchesResponseModel> getMySearches({
    required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientSearchesGet}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );

    return GetMySearchesResponseModel.fromJson(response);
  }

  @override
  Future<void> deleteOneMySearch(
      {required DeleteOneMySearchRequestModel
          deleteOneMySearchRequestModel}) async {
    await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientSearchesDelete}',
      isFormData: true,
      data: deleteOneMySearchRequestModel.toJson(),
    );
  }
}
