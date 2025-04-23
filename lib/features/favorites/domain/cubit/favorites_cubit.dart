import 'package:bloc/bloc.dart';
import 'package:emtelek/features/favorites/data/repositories/favorites_repository.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;
  FavoritesCubit(this.favoritesRepository) : super(FavoritesInitial());

  List<AdsModel> myFavoriteAds = [];

  Future<void> getFavoritesData() async {
    try {
      emit(FavoritesLoading());
      myFavoriteAds = await favoritesRepository.getMyFavoriteAds();
      emit(FavoritesSuccess());
    } catch (e) {
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
