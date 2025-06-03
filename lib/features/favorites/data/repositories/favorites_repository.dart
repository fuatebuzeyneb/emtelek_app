import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/favorites/data/models/get_favorite_response_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

abstract class FavoritesRepository {
  Future<GetFavoriteResponseModel> getFavoriteAds(
      {required TokenAndClintIdRequestModel tokenAndClintIdRequestModel});

  Future<void> removeFavoriteAd({required int adId});

  Future<void> addFavoriteAd({required int adId});
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final ApiConsumer api;

  FavoritesRepositoryImpl({required this.api});

  @override
  Future<GetFavoriteResponseModel> getFavoriteAds({
    required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.clientsFavoriteAds}',
      isFormData: true,
      data: tokenAndClintIdRequestModel.toJson(),
    );

    if (response == null || response["ads"] == null) {
      throw Exception("No ads found");
    }

    return GetFavoriteResponseModel.fromJson(response);
  }

  @override
  Future<void> addFavoriteAd({required int adId}) async {
    try {
      final data = {
        "Token": getIt<CacheHelper>().getDataString(key: 'token'),
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
        "AdId": adId
      };

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsAddFavorite}',
        isFormData: true,
        data: data,
      );

      print("Response: $response");
    } catch (e) {
      print("Error in getMyAds3: $e");
      throw Exception("No ads found");
    }
  }

  @override
  Future<void> removeFavoriteAd({required int adId}) async {
    try {
      final data = {
        "Token": getIt<CacheHelper>().getDataString(key: 'token'),
        "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
        "AdId": adId
      };

      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsRemoveFavorite}',
        isFormData: true,
        data: data,
      );

      print("Response: $response");
    } catch (e) {
      print("Error in getMyAds5: $e");
      throw Exception("No ads found");
    }
  }
}
