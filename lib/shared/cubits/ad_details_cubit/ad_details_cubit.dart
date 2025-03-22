import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'ad_details_state.dart';

class AdDetailsCubit extends Cubit<AdDetailsState> {
  AdDetailsCubit() : super(AdDetailsInitial());

  ///image sild
  ///map points
  ///show features
  ///show appBar

  bool showAppBar = false;
  double scrollThreshold = 100.0;

  void showAppBarFunction(ScrollController scrollController) {
    scrollController.addListener(() {
      // حساب النسبة المئوية للتمرير
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      // حساب النسبة المئوية
      double scrollPercentage = currentScroll / maxScroll;

      // طباعة النسبة المئوية للتمرير
      if (scrollPercentage > 0.3) {
        showAppBar = true;
      } else if (scrollPercentage < 0.3) {
        showAppBar = false;
      }
      emit(ShowAppBarState());
    });

    print('showAppBar $showAppBar');
  }

  bool descriptionIsExpanded = false;
  void descriptionIsExpandedFunction() {
    descriptionIsExpanded = !descriptionIsExpanded;
    emit(DescriptionIsExpandedState());
  }

  bool showAllFeatures = false;
  void showAllFeaturesFunction() {
    showAllFeatures = !showAllFeatures;
    emit(ShowAllFeaturesState());
  }

  int currentPage = 0;
  void currentPageFunction(int index) {
    currentPage = index;
    emit(CurrentImageState());
  }
}
