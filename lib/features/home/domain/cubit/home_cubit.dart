import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emtelek/features/home/data/models/get_home_response_model.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/home/data/models/search_request_model.dart';
import 'package:emtelek/features/home/data/repositories/home_repository.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());

  //-------------------------for home search----------------------

  int currentIndex = 0;
  late Map<String, dynamic> currentIconAndText;

  List<Map<String, dynamic>> iconsAndTexts = [];

  void updateIconsAndTexts(
      {required String findHomeText,
      required String findCarText,
      required String findOfficeText,
      required String findLandText}) {
    iconsAndTexts = [
      {'image': 'assets/icons/home.png', 'text': findHomeText},
      {'image': 'assets/icons/car.png', 'text': findCarText},
      {'image': 'assets/icons/office.png', 'text': findOfficeText},
      {'image': 'assets/icons/land.png', 'text': findLandText},
    ];
    currentIconAndText = iconsAndTexts[currentIndex];
  }

  Timer? _timer;

  // بدء الـ Timer لتغيير الأيقونة والنص
  void startTimer() {
    print('start timer====================================');
    _timer = Timer.periodic(const Duration(seconds: 7), _updateTextAndIcon);
  }

  // تحديث الأيقونة والنص عند مرور الوقت
  void _updateTextAndIcon(Timer timer) {
    currentIndex = (currentIndex + 1) % iconsAndTexts.length;
    currentIconAndText = iconsAndTexts[currentIndex];
    emit(HomeSearchChangerState());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  List<Property>? propertiesRent;
  List<Property>? propertiesSell;

  Future<void> getHomeData() async {
    emit(HomeAdsLoading());
    try {
      final response = await homeRepository.getHomeAds(
          tokenAndClintIdRequestModel: TokenAndClintIdRequestModel(
        token: getIt<CacheHelper>().getDataString(key: 'token') ?? "null",
        clientId: getIt<CacheHelper>().getData(key: 'clientId') ?? 0,
      ));
      propertiesRent = response.propertiesRent;
      propertiesSell = response.propertiesSell;

      print('propertiesSell------------: ${response.propertiesRent?.length}');
      print('propertiesRent---------: ${response.propertiesSell?.length}');
      emit(HomeAdsSuccess());
      print('ok');
    } catch (e) {
      print('nooooooo $e');
      emit(HomeAdsFailure(errorMassage: e.toString()));
    }
  }

  List<Property> searchAdsList = [];

  Future<void> getSearchAds({required String searchTitle}) async {
    emit(HomeTextSearchAdsLoading());
    try {
      final response = await homeRepository.getSearchAds(
          searchRequestModel: SearchRequestModel(
              token: getIt<CacheHelper>().getDataString(key: 'token') ?? "null",
              clientId: getIt<CacheHelper>().getData(key: 'clientId') ?? 0,
              searchQuery: searchTitle,
              page: 0,
              orderBy: 'PublishDate ASC1'));

      if (response.hasData) {
        searchAdsList = response.data;
        emit(HomeTextSearchAdsSuccess());
      } else {
        emit(HomeTextSearchAdsFailure(errorMassage: 'No ads found!'));
      }
    } catch (e) {
      emit(HomeTextSearchAdsFailure(errorMassage: e.toString()));
    }
  }

  void clearSearchResults() {
    searchAdsList.clear();
    emit(HomeTextSearchAdsInitial());
  }
}
