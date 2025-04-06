import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/search_property/data/models/property_filter_request_mode.dart';
import 'package:emtelek/features/search_property/data/repositories/search_property_repository.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/models/city-model/city_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final SearchPropertyRepository searchPropertyRepository;
  PropertyCubit(this.searchPropertyRepository) : super(PropertyInitial());

//***********************************for filter*******************************

//-------------------------for ad type----------------------

// 6--> buy
// 5--> rent
  int? adType;

  changeAdType(int type) {
    adType = type;
    emit(PropertyInitial());
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

  late int propertyType;

  changePropertyType(int type) {
    propertyType = type;
    print('propertyType: $propertyType');
    emit(PropertyInitial());
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
    emit(PropertyInitial());
  }

  removeListRoomCount(int type) {
    listRoomCount.remove(type);
    emit(PropertyInitial());
  }

  //-------------------------for BathRoom Count----------------------

  List<int> listBathRoomCount = [];

  addListBathRoomCount(int type) {
    listBathRoomCount.add(type);
    emit(PropertyInitial());
  }

  removeListBathRoomCount(int type) {
    listBathRoomCount.remove(type);
    emit(PropertyInitial());
  }

  //-------------------------for Furnished & Unfurnished----------------------

// 0--> all
// 1--> furnished
// 2--> unfurnished

  int furnishedType = 0;

  changeFurnishedType(int type) {
    furnishedType = type;
    emit(PropertyInitial());
  }

  //-------------------------for Posted By--------------------------------------

// 0--> all
// 1--> owner
// 2--> agent

  int sellerType = 0;

  changePostedByType(int type) {
    sellerType = type;
    emit(PropertyInitial());
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

  //***********************************for get property*******************************

  List<AdsModel> filteredAds = [];
  Future<void> applyFilter(
      {required List<int> listCityIds,
      required List<int> listDistrictIds,
      required int? minPrice,
      required int? maxPrice,
      String? sortBy}) async {
    emit(PropertyAdsFilterLoading());
    try {
      filteredAds = await searchPropertyRepository.getFilteredAds(
        PropertyFilterRequestModel(
            token: getIt<CacheHelper>().getDataString(key: 'token'),
            clientId: getIt<CacheHelper>().getData(key: 'clientId'),
            categoryId: propertyType,
            sellerType: sellerType == 0 ? null : sellerType,
            roomCount: listRoomCount.isEmpty ? null : listRoomCount,
            furnish: furnishedType == 0
                ? null
                : furnishedType == 1
                    ? 'true'
                    : 'false',
            cityId: listCityIds.isEmpty ? null : listCityIds,
            districtId: listDistrictIds.isEmpty ? null : listDistrictIds,
            bathroomCount: listBathRoomCount.isEmpty ? null : listBathRoomCount,
            minPrice: minPrice,
            maxPrice: maxPrice,
            minTotalArea: minArea?.toInt(),
            maxTotalArea: maxArea?.toInt(),
            orderBy: sortBy,
            page: null),
      );

      // ✅ طباعة منظمة لنتائج الفلتر
      if (filteredAds.isNotEmpty) {
        emit(PropertyAdsFilterSuccess());
      } else {
        emit(PropertyAdsFilterFailure(errMessage: 'No ads found!'));
        print('🚫 No ads found!');
      }
    } catch (e) {
      emit(PropertyAdsFilterFailure(errMessage: e.toString()));
      print('❌ Error loading filtered ads: $e');
    }
  }
}
//  List<dynamic> selectCitiesAndDistricts = [];
