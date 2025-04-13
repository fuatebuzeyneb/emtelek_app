import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/services/shared_preferences_funs.dart';
import 'package:emtelek/shared/models/city-model/city_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  late Map<int, String> rentCategories;
  late Map<int, String> saleCategories;

  void initCategories() {
    rentCategories = {
      7: S.current.Room,
      8: S.current.Apartment,
      9: S.current.Shop,
      10: S.current.Building,
      11: S.current.Land,
      12: S.current.Villa,
      13: S.current.Factory,
      27: S.current.Office,
    };

    saleCategories = {
      14: S.current.Apartment,
      15: S.current.Shop,
      16: S.current.Building,
      17: S.current.Land,
      18: S.current.Villa,
      19: S.current.Factory,
      26: S.current.Office,
    };

    emit(SettingsInitial());
  }

  //---------------------------------------language---------------------------

  String locale = getIt<CacheHelper>().getDataString(key: 'Lang') ?? 'ar';

  void selectLanguageFunction({required String value}) {
    locale = value;
    saveLanguage(value);

    emit(SettingsInitial());
  }

  //---------------------------------------CurrencyConversion---------------------------

//SYP --> Syrian
//USD --> American
//TRL --> Turkish
  String currencyCode =
      getIt<CacheHelper>().getDataString(key: 'currencyCode') ?? 'SYP';

  void selectCurrencyCodeFunction({required String value}) {
    currencyCode = value;
    saveCurrencyCode(value);

    emit(SettingsInitial());
  }

  //---------------------------------------cities---------------------------

  List<CityModel> globalCities = [];
  Box<CityModel>? citiesBox;

  List<DistrictModel> globalDistricts = [];
  Box<DistrictModel>? districtsBox;
  Dio dio = Dio();
  String apiUrl = EndPoints.baseUrl;
  String basicAuth =
      'Basic ${base64Encode(utf8.encode('${ApiKey.emtelekAuthUsername}:${ApiKey.emtelekAuthPass}'))}';
  Future<void> openBox() async {
    citiesBox = await Hive.openBox<CityModel>('cityBox');
    districtsBox = await Hive.openBox<DistrictModel>('districtBox');
    if (citiesBox!.isNotEmpty) {
      globalCities = citiesBox!.values.toList();
      emit(CityLoaded());
    } else {
      await fetchCitiesFromApi();
      globalCities = citiesBox!.values.toList();
    }
    if (districtsBox!.isNotEmpty) {
      globalDistricts = districtsBox!.values.toList();
      emit(CityLoaded());
    } else {
      await fetchDistrictFromApi();
      globalDistricts = districtsBox!.values.toList();
    }
  }

  Future<void> fetchCitiesFromApi() async {
    try {
      emit(CityLoading());

      List<dynamic> citiesData = await getCityDataFromApi();

      for (var city in citiesData) {
        if (city.containsKey('CityId') && city.containsKey('CityName')) {
          citiesBox!.add(
              CityModel(cityId: city['CityId'], cityName: city['CityName']));
        }
      }

      emit(CityLoaded());
    } catch (e) {
      emit(CityError('Failed to load cities'));
    }
  }

  Future<List<dynamic>> getCityDataFromApi() async {
    try {
      Response response = await dio.get(
        '$apiUrl/cities',
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['data'] is Map) {
          Map<String, dynamic> cities = response.data['data'];
          List<dynamic> citiesList = [];

          cities.forEach((key, value) {
            citiesList.add(value);
          });

          return citiesList;
        } else {
          throw Exception('Data format is not correct');
        }
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  //---------------------------------------districts---------------------------

  Future<void> fetchDistrictFromApi() async {
    try {
      emit(CityLoading());

      List<dynamic> districtsData = await getDistrictDataFromApi();

      for (var district in districtsData) {
        if (district.containsKey('CityId') &&
            district.containsKey('DistrictId') &&
            district.containsKey('DistrictName')) {
          districtsBox!.add(DistrictModel(
              cityId: district['CityId'],
              districtId: district['DistrictId'],
              districtName: district['DistrictName']));
        }
      }

      emit(CityLoaded());
    } catch (e) {
      emit(CityError('Failed to load districts'));
    }
  }

  Future<List<dynamic>> getDistrictDataFromApi() async {
    try {
      Response response = await dio.get(
        '$apiUrl/districts',
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['data'] is Map) {
          // استخراج البيانات من الخريطة
          Map<String, dynamic> districts = response.data['data'];

          // تحويل الخريطة إلى قائمة
          List<dynamic> districtsList = [];
          districts.forEach((key, value) {
            districtsList.add(value);
          });

          return districtsList;
        } else {
          throw Exception('Data format is not correct');
        }
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

//this function will return the districts of the selected city
  int? cityId;
  void selectCityId(int id) {
    cityId = id;

    emit(SettingsInitial());
  }

  LatLng parseLatLng(String locationString) {
    List<String> coordinates = locationString.split(",");
    double latitude = double.parse(coordinates[0].trim());
    double longitude = double.parse(coordinates[1].trim());
    return LatLng(latitude, longitude);
  }

  String getCityNameByDistrictId(int districtId) {
    // ابحث عن المدينة باستخدام CityId بناءً على DistrictId
    for (var district in globalDistricts) {
      if (district.districtId == districtId) {
        // ابحث عن المدينة بناءً على CityId
        var city = globalCities.firstWhere(
          (city) => city.cityId == district.cityId,
        );
        return city.cityName ?? S.current.undefined;
      }
    }
    return S.current.undefined;
  }

  String getDistrictNameByDistrictId(int districtId) {
    // ابحث عن المنطقة باستخدام DistrictId
    var district = globalDistricts.firstWhere(
      (district) => district.districtId == districtId,
    );
    return district.districtName ?? S.current.undefined;
  }

  String getCityNameByCityId(int cityId) {
    // ابحث عن المدينة باستخدام CityId
    var city = globalCities.firstWhere(
      (city) => city.cityId == cityId,
    );
    return city.cityName ?? S.current.undefined;
  }

  Map<String, dynamic> getStatusInfo(int status) {
    switch (status) {
      case 1:
        return {
          'color': Colors.blue, // Active
          'text': 'Active',
        };
      case 2:
        return {
          'color': Colors.grey, // Passive
          'text': 'Passive',
        };
      case 3:
        return {
          'color': Colors.red, // Deleted
          'text': 'Deleted',
        };
      case 4:
        return {
          'color': Colors.orange, // Archived
          'text': 'Archived',
        };
      case 5:
        return {
          'color': Colors.yellow, // Waiting
          'text': 'Waiting',
        };
      default:
        return {
          'color': Colors.black, // Default color for invalid status
          'text': 'Unknown Status',
        };
    }
  }

  String? getCategoryName(int categoryId) {
    List<Map<String, dynamic>> categories = [
      {"CategoryId": 7, "CategoryName": S.current.Apartment},
      {"CategoryId": 8, "CategoryName": S.current.Room},
      {"CategoryId": 9, "CategoryName": S.current.Shop},
      {"CategoryId": 10, "CategoryName": S.current.Building},
      {"CategoryId": 11, "CategoryName": S.current.Land},
      {"CategoryId": 12, "CategoryName": S.current.Villa},
      {"CategoryId": 13, "CategoryName": S.current.Factory},
      {"CategoryId": 14, "CategoryName": S.current.Apartment},
      {"CategoryId": 15, "CategoryName": S.current.Shop},
      {"CategoryId": 16, "CategoryName": S.current.Building},
      {"CategoryId": 17, "CategoryName": S.current.Land},
      {"CategoryId": 18, "CategoryName": S.current.Villa},
      {"CategoryId": 19, "CategoryName": S.current.Factory},
      {"CategoryId": 26, "CategoryName": S.current.Office},
      {"CategoryId": 27, "CategoryName": S.current.Office},
    ];

    var category = categories.firstWhere(
      (cat) => cat['CategoryId'] == categoryId,
      orElse: () => {"CategoryName": null},
    );

    return category['CategoryName'];
  }

  String isForSale(int categoryId) {
    List<int> saleCategories = [14, 15, 16, 17, 18, 19, 26];

    return saleCategories.contains(categoryId)
        ? S.current.Sale
        : S.current.Rent;
  }

  List<CityModel> filteredCities = [];
  List<DistrictModel> filteredDistricts = [];
  List<dynamic> selectCitiesAndDistricts = [];
  List<int> selectedCityIds = [];
  List<int> selectedDistrictIds = [];

  void filterLocations({
    required String value,
    required List<CityModel> globalCities,
    required List<DistrictModel> globalDistricts,
  }) {
    String normalizedValue =
        value.replaceAll(RegExp(r'[أإآ]'), 'ا').toLowerCase();

    if (normalizedValue.length < 3) {
      filteredCities = [];
      filteredDistricts = [];
    } else {
      filteredCities = globalCities
          .where((city) => city.cityName
              .replaceAll(RegExp(r'[أإآ]'), 'ا')
              .toLowerCase()
              .contains(normalizedValue))
          .toList();

      filteredDistricts = globalDistricts
          .where((district) =>
              district.districtName
                  .replaceAll(RegExp(r'[أإآ]'), 'ا')
                  .toLowerCase()
                  .contains(normalizedValue) ||
              filteredCities.any((city) => city.cityId == district.cityId))
          .toList();
    }

    emit(LocationFilterSelect());
  }

  void selectLocation({required dynamic value}) {
    if (!selectCitiesAndDistricts.contains(value)) {
      selectCitiesAndDistricts.add(value);
      print('selectCitiesAndDistricts: $selectCitiesAndDistricts');
      emit(LocationFilterSelect());
    }
  }

  void unSelectLocation({required int index}) {
    selectCitiesAndDistricts.removeAt(index);
    emit(LocationFilterSelect());
  }

  void processLocations() {
    selectedCityIds = selectCitiesAndDistricts
        .whereType<CityModel>()
        .map((city) => city.cityId)
        .toList();

    selectedDistrictIds = selectCitiesAndDistricts
        .whereType<DistrictModel>()
        .map((district) => district.districtId)
        .toList();

    // تصفية المناطق بناءً على المدينة المحددة مباشرةً بدون دالة خارجية
    selectedDistrictIds = selectedDistrictIds.where((districtId) {
      var district = globalDistricts.firstWhere(
        (d) => d.districtId == districtId,
        orElse: () =>
            DistrictModel(districtId: -1, cityId: -1, districtName: ''),
      );

      return district.districtId == -1 ||
          !selectedCityIds.contains(district.cityId);
    }).toList();
  }

  /// price filter Range

  double? minPrice;
  double? maxPrice;

  void updateMinPrice(double? value) {
    minPrice = value;
    emit(PriceFilterRange());
  }

  void updateMaxPrice(double? value) {
    maxPrice = value;
    emit(PriceFilterRange());
  }

  void updatePriceRange(double lowerValue, double upperValue) {
    minPrice = lowerValue;
    maxPrice = upperValue;

    print('minPrice: $minPrice, maxPrice: $maxPrice');
    emit(PriceFilterRange());
  }

  String sortBy = "PublishDate DESC";
  void selectSortByFunction({required String value}) {
    sortBy = value;
    print('sortBy: $sortBy');
    emit(SortBy());
  }
}
