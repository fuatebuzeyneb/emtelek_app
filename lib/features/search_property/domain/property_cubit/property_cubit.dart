import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/features/search_property/data/models/property_filter_mode.dart';
import 'package:emtelek/features/search_property/data/repositories/search_property_repository.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/models/city-model/city_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
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

//-------------------------for location----------------------
  List<CityModel> filteredCities = [];
  List<DistrictModel> filteredDistricts = [];
  List<dynamic> selectCitiesAndDistricts = [];
  void filterCities(
      {required String value, required List<CityModel> globalCities}) {
    String normalizedValue =
        value.replaceAll('أ', 'ا').replaceAll('إ', 'ا').replaceAll('آ', 'ا');

    if (normalizedValue.isEmpty) {
      filteredCities = [];
    } else {
      filteredCities = globalCities.where((city) {
        String normalizedCityName = city.cityName
            .replaceAll('أ', 'ا')
            .replaceAll('إ', 'ا')
            .replaceAll('آ', 'ا');

        return normalizedCityName
            .toLowerCase()
            .contains(normalizedValue.toLowerCase());
      }).toList();
    }

    emit(PropertyInitial());
  }

  void filterDistricts(
      {required String value, required List<DistrictModel> globalDistricts}) {
    String normalizedValue =
        value.replaceAll('أ', 'ا').replaceAll('إ', 'ا').replaceAll('آ', 'ا');

    if (normalizedValue.isEmpty) {
      filteredDistricts = [];
    } else {
      filteredDistricts = globalDistricts.where((district) {
        String normalizedDistrictName = district.districtName
            .replaceAll('أ', 'ا')
            .replaceAll('إ', 'ا')
            .replaceAll('آ', 'ا');

        return normalizedDistrictName
            .toLowerCase()
            .contains(normalizedValue.toLowerCase());
      }).toList();
    }

    emit(PropertyInitial());
  }

  // دالة لتصفية المدن والمناطق بناءً على النص المدخل
  void filterCitiesAndDistricts({
    required String value,
    required List<CityModel> globalCities,
    required List<DistrictModel> globalDistricts,
  }) {
    // تطبيع النص المدخل بحيث يتعامل مع الحروف المشابهة مثل "أ" و "إ"
    String normalizedValue =
        value.replaceAll('أ', 'ا').replaceAll('إ', 'ا').replaceAll('آ', 'ا');

    // إذا كان النص المدخل يحتوي على 3 أحرف أو أكثر
    if (normalizedValue.length >= 3) {
      // تصفية المدن التي تحتوي على النص المدخل
      List<CityModel> filteredCities = globalCities.where((city) {
        String normalizedCityName = city.cityName
            .replaceAll('أ', 'ا')
            .replaceAll('إ', 'ا')
            .replaceAll('آ', 'ا');
        return normalizedCityName
            .toLowerCase()
            .contains(normalizedValue.toLowerCase());
      }).toList();

      // قائمة لتخزين المناطق التي تتبع للمدن المصفاة
      List<DistrictModel> matchingDistricts = [];

      // البحث عن المناطق التي تنتمي إلى هذه المدن بناءً على الـ CityId
      for (var city in filteredCities) {
        // إضافة المناطق التي تتبع لـ CityId الخاص بالمدينة
        matchingDistricts.addAll(globalDistricts.where((district) {
          return district.cityId == city.cityId;
        }).toList());
      }

      // تحديث المتغيرات المعنية
      filterCities(
          value: value,
          globalCities: globalCities); // تحديث قائمة المدن المصفاة

      filteredDistricts = matchingDistricts;

      if (filteredDistricts.isEmpty) {
        filterDistricts(value: value, globalDistricts: globalDistricts);
      }
      // يمكن أن تستخدم emit هنا لإعادة تفعيل الواجهة أو الحالة إذا كنت تستخدم Bloc أو Cubit
      emit(PropertyInitial());
    } else {
      // إذا كان النص المدخل أقل من 3 أحرف، نقوم بفلترة المدن والمناطق بالطريقة العادية
      filterCities(value: value, globalCities: globalCities);
      filterDistricts(value: value, globalDistricts: globalDistricts);
    }
  }

  void selectCityAndDistricts({required dynamic value}) {
    selectCitiesAndDistricts.add(value);
    emit(PropertyInitial());
  }

  void unSelectCityAndDistricts({required int index}) {
    selectCitiesAndDistricts.removeAt(index);
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
// 22---> office

//for buy
// 14---> house
// 15---> store
// 16---> apartment
// 17---> land
// 18---> villa
// 19---> facility
// 23---> office

  int propertyType = 8;

  changePropertyType(int type) {
    propertyType = type;
    emit(PropertyInitial());
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

//***********************************for home*******************************

  //***********************************for get property*******************************

  List<AdsModel> filteredAds = [];
  Future<void> applyFilter() async {
    try {
      filteredAds = await searchPropertyRepository.getFilteredAds(
        PropertyFilterModel(
          categoryId: 14,
          sellerType: null,
          roomCount: null,
          furnish: null,
          cityId: null,
          districtId: null,
          bathroomCount: null,
          minPrice: null,
          maxPrice: null,
          minTotalArea: null,
          maxTotalArea: null,
          minNetArea: null,
          maxNetArea: null,
          floorCount: null,
          minConstructionDate: null,
          maxConstructionDate: null,
          balconyCount: null,
        ),
      );

      // ✅ طباعة منظمة لنتائج الفلتر
      if (filteredAds.isNotEmpty) {
        for (var ad in filteredAds) {
          print('✅ Ad: ${ad.toJson()}');
        }
      } else {
        print('🚫 No ads found!');
      }
    } catch (e) {
      print('❌ Error loading filtered ads: $e');
    }
  }
}
