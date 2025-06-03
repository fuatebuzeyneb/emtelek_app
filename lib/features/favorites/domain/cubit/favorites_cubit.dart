import 'package:bloc/bloc.dart';
import 'package:emtelek/features/favorites/data/models/get_favorite_response_model.dart';
import 'package:emtelek/features/favorites/data/repositories/favorites_repository.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;
  FavoritesCubit(this.favoritesRepository) : super(FavoritesInitial());

  List<Property>? myFavoriteAds;

  Future<void> getFavoritesData() async {
    try {
      emit(FavoritesLoading());
      final response = await favoritesRepository.getFavoriteAds(
        tokenAndClintIdRequestModel: TokenAndClintIdRequestModel(
          token: getIt<CacheHelper>().getDataString(key: 'token')!,
          clientId: getIt<CacheHelper>().getData(key: 'clientId'),
        ),
      );

      myFavoriteAds = response.properties;
      emit(FavoritesSuccess());
    } catch (e) {
      print("Error in ProfileCubit=====: $e");
      emit(FavoritesFailure(errorMassage: e.toString()));
    }
  }

  Future<void> addFavorite({required int adId}) async {
    try {
      await favoritesRepository.addFavoriteAd(adId: adId);
      getFavoritesData();
      emit(FavoritesSuccess());
    } catch (e) {
      emit(FavoritesFailure(errorMassage: e.toString()));
    }
  }

  Future<void> removeFavorite({required int adId}) async {
    try {
      await favoritesRepository.removeFavoriteAd(adId: adId);
      getFavoritesData();
      emit(FavoritesSuccess());
    } catch (e) {
      emit(FavoritesFailure(errorMassage: e.toString()));
    }
  }
}
