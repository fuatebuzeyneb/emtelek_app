import 'package:bloc/bloc.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:emtelek/features/my_searches/data/models/get_my_searches_response_model.dart';
import 'package:emtelek/features/property_filter/data/models/property_filter_request_model.dart';
import 'package:emtelek/features/property_filter/data/models/save_search_filter_request_model.dart';
import 'package:emtelek/features/property_filter/data/repositories/property_filter_repository.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:meta/meta.dart';

part 'property_filter_state.dart';

class PropertyFilterCubit extends Cubit<PropertyFilterState> {
  final PropertyFilterRepository propertyFilterRepository;
  PropertyFilterCubit(this.propertyFilterRepository)
      : super(PropertyFilterInitial());

  // 6--> buy
// 5--> rent
  int? adType;

  changeAdType(int type) {
    adType = type;
    emit(PropertyFilterInitial());
  }

//-------------------------for type property----------------------

//for rent
// 7---> room
// 8---> house
// 9---> store
// 10---> apartment
// 11---> land
// 12---> villa
// 13---> facility
// 26---> office

//for buy
// 14---> house
// 15---> store
// 16---> apartment
// 17---> land
// 18---> villa
// 19---> facility
// 27---> office

  int? propertyType;

  changePropertyType(int type) {
    propertyType = type;
    print('propertyType: $propertyType');
    emit(PropertyFilterInitial());
  }

  void switchPropertyType() {
    if (adType == 5) {
      switch (propertyType) {
        case 14:
          propertyType = 8;
          break;
        case 15:
          propertyType = 9;
          break;
        case 16:
          propertyType = 10;
          break;
        case 17:
          propertyType = 11;
          break;
        case 18:
          propertyType = 12;
          break;
        case 19:
          propertyType = 13;
          break;
        case 26:
          propertyType = 27;
          break;
        default:
          break;
      }
    } else {
      switch (propertyType) {
        case 8:
          propertyType = 14;
          break;
        case 9:
          propertyType = 15;
          break;
        case 10:
          propertyType = 16;
          break;
        case 11:
          propertyType = 17;
          break;
        case 12:
          propertyType = 18;
          break;
        case 13:
          propertyType = 19;
          break;
        case 27:
          propertyType = 26;
          break;
        default:
          break;
      }
    }

    print('after switch: $propertyType');
  }

//-------------------------for Room Count----------------------

  List<int> listRoomCount = [];

  addListRoomCount(int type) {
    listRoomCount.add(type);
    emit(PropertyFilterInitial());
  }

  removeListRoomCount(int type) {
    listRoomCount.remove(type);
    emit(PropertyFilterInitial());
  }

  //-------------------------for BathRoom Count----------------------

  List<int> listBathRoomCount = [];

  addListBathRoomCount(int type) {
    listBathRoomCount.add(type);
    emit(PropertyFilterInitial());
  }

  removeListBathRoomCount(int type) {
    listBathRoomCount.remove(type);
    emit(PropertyFilterInitial());
  }

  //-------------------------for Furnished & Unfurnished----------------------

// 0--> all
// 1--> furnished
// 2--> unfurnished

  int furnishedType = 0;

  changeFurnishedType(int type) {
    furnishedType = type;
    emit(PropertyFilterInitial());
  }

  //-------------------------for Posted By--------------------------------------

// 0--> all
// 1--> owner
// 2--> agent

  int sellerType = 0;

  changePostedByType(int type) {
    sellerType = type;
    emit(PropertyFilterInitial());
  }

  //***********************************for Area*******************************

  double? minArea;
  double? maxArea;

  void updateMinArea(double? value) {
    maxArea = value;
    emit(PropertyFilterAreaRange());
  }

  void updateMaxArea(double? value) {
    maxArea = value;
    emit(PropertyFilterAreaRange());
  }

  void updateAreaRange(double lowerValue, double upperValue) {
    minArea = lowerValue;
    maxArea = upperValue;

    print('minArea: $minArea, maxArea: $maxArea');
    emit(PropertyFilterAreaRange());
  }

  String titleOfSavedSearch = 'بحث جديد';

  List<Property>? listProperty;

  Future<void> getFilterAds({
    required PropertyFilterRequestModel propertyFilterRequestModel,
  }) async {
    emit(PropertyFilterLoading());
    print('propertyFilterRequestModel: ${propertyFilterRequestModel.toJson()}');
    try {
      final response = await propertyFilterRepository.getFilterAds(
        propertyFilterRequestModel: propertyFilterRequestModel,
      );

      if (response.data != null && response.data!.isNotEmpty) {
        listProperty = response.data;
        emit(PropertyFilterSuccess());
      } else {
        emit(PropertyFilterFailure(
            errMessage: 'No Property Found Try Again with new filters'));
      }
    } catch (e) {
      emit(PropertyFilterFailure(errMessage: e.toString()));
    }
  }

  // List<SearchFilterItemModel>? mySavedSearchFilterList;
  // Future<void> getSavedFilterSearchAds({
  //   required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
  // }) async {
  //   emit(GetSearchFilterLoading());

  //   try {
  //     final response = await propertyFilterRepository.getSavedFilterSearchAds(
  //       tokenAndClintIdRequestModel: tokenAndClintIdRequestModel,
  //     );

  //     if (response.data != null && response.data!.isNotEmpty) {
  //       mySavedSearchFilterList = response.data;
  //       emit(GetSearchFilterSuccess());
  //     } else {
  //       emit(GetSearchFilterFailure(errMessage: 'No saved filters found!'));
  //     }
  //   } catch (e) {
  //     emit(GetSearchFilterFailure(errMessage: e.toString()));
  //   }
  // }

  Future<void> saveSearchFilter({
    required SaveSearchFilterRequestModel saveSearchFilterRequestModel,
  }) async {
    emit(SaveSearchPropertyFilterLoading());
    print(
        'SaveSearchFilterRequestModel: ${saveSearchFilterRequestModel.toJson()}');
    try {
      await propertyFilterRepository.saveSearchFilter(
        saveSearchFilterRequestModel: saveSearchFilterRequestModel,
      );
      emit(SaveSearchPropertyFilterSuccess());
    } catch (e) {
      emit(SaveSearchPropertyFilterFailure(errMessage: e.toString()));
    }
  }
}
