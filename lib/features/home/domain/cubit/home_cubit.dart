import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emtelek/features/home/data/models/home_model.dart';
import 'package:emtelek/features/home/data/repositories/home_repository.dart';
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

  late HomeModel homeModel;

  Future<void> getHomeData() async {
    try {
      emit(HomeAdsLoading());
      homeModel = await homeRepository.getHomeAds();
      emit(HomeAdsSuccess());
    } catch (e) {
      emit(HomeAdsFailure(errorMassage: e.toString()));
    }
  }
}
