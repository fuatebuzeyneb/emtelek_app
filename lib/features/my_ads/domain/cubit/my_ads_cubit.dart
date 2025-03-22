import 'package:bloc/bloc.dart';
import 'package:emtelek/core/errors/exceptions.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/features/my_ads/data/repositories/my_ads_repository.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/add-ads-models/add_ad_model.dart';
import 'package:emtelek/shared/models/all_response.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  final MyAdsRepository myAdsRepository;
  MyAdsCubit(this.myAdsRepository) : super(MyAdsInitial());

  late int editIndex;

  // void setEditIndex({required int index}) {
  //   print('index: $index');
  //   editIndex = index;
  // }

  List<AdsModel> myAds = [];

  Future<void> getMyAds() async {
    print('----------------------------------');
    emit(GetMyAdsLoading());
    try {
      final rawData = await myAdsRepository.getMyAds();

      if (rawData.isEmpty) {
        print("No ads data received");
      }

      myAds = rawData;
      print(myAds.length);
      print(myAds[0].adId); // طباعة ID أول إعلان
      emit(GetMyAdsSuccess());
    } catch (e) {
      print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
      emit(GetMyAdsFailure(errorMassage: e.toString()));
    }
  }

  late AdsModel adsModel;

  void setEditIndex({required int index}) {
    print('index: $index');
    editIndex = index;

    // تحديث adsModel بناءً على الإندكس الجديد
    adsModel = AdsModel(
      token: getIt<CacheHelper>().getDataString(key: 'token')!,
      adId: myAds[editIndex].adId,
      adTitle: myAds[editIndex].adTitle,
      price: myAds[editIndex].price,
      currency: myAds[editIndex].currency,
      description: myAds[editIndex].description,
      location: myAds[editIndex].location,
      publishDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      status: 5,
      sellerType: myAds[editIndex].sellerType,
      categoryId: myAds[editIndex].categoryId,
      clientId: myAds[editIndex].clientId,
      firstName: myAds[editIndex].firstName,
      lastName: myAds[editIndex].lastName,
      phoneNumber: myAds[editIndex].phoneNumber,
      email: myAds[editIndex].email,
      subscriptionDate: myAds[editIndex].subscriptionDate,
      districtId: myAds[editIndex].districtId,
      totalArea: myAds[editIndex].totalArea,
      netOrBuildingArea: myAds[editIndex].netOrBuildingArea,
      roomCount: myAds[editIndex].roomCount,
      floorNumber: myAds[editIndex].floorNumber,
      floorCount: myAds[editIndex].floorCount,
      bathroomCount: myAds[editIndex].bathroomCount,
      constructionDate: myAds[editIndex].constructionDate,
      address: myAds[editIndex].address,
      balconyCount: myAds[editIndex].balconyCount,
      complexName: myAds[editIndex].complexName,
    );

    // إعادة بناء الحالة لتحديث واجهة المستخدم إذا لزم الأمر
    emit(MyAdsInitial());
  }

  // late AdsModel adsModel;
  void updatePropertyField(
    String field,
    dynamic value,
  ) {
    if (field == 'totalArea') {
      adsModel.totalArea = value;
    } else if (field == 'netOrBuildingArea') {
      adsModel.netOrBuildingArea = value;
    } else if (field == 'roomCount') {
      adsModel.roomCount = value;
    } else if (field == 'bathroomCount') {
      adsModel.bathroomCount = value;
    } else if (field == 'floorCount') {
      adsModel.floorCount = value;
    } else if (field == 'floorNumber') {
      adsModel.floorNumber = value;
    } else if (field == 'balconyCount') {
      adsModel.balconyCount = value;
    } else if (field == 'constructionDate') {
      adsModel.constructionDate = value;
    } else if (field == 'furnished') {
      print('furnished====: $value');
      adsModel.furnish = value;
    } else if (field == 'complexName') {
      adsModel.complexName = value;
    } else if (field == 'adModelTitle') {
      adsModel.adTitle = value;
    } else if (field == 'adModelPrice') {
      adsModel.price = value;
    } else if (field == 'adModelLocation') {
      adsModel.location = value;
    }
    // else if (field == 'adModelImage') {
    //  adsModel.image = value;
    // }
    else if (field == 'adModelDescription') {
      adsModel.description = value;
    } else if (field == 'adModelPhone') {
      print('adModelPhone====: $value');
      adsModel.phoneNumber = value;
    } else if (field == 'adModelCurrency') {
      adsModel.currency = value;
    } else if (field == 'adModelEmail') {
      adsModel.email = value;
    } else if (field == 'adModelDistrictId') {
      adsModel = value;
    } else if (field == 'adModelClientId') {
      adsModel.clientId = value;
    } else if (field == 'adModelSellerType') {
      adsModel.sellerType = value;
    } else if (field == 'adModelCategoryId') {
      adsModel.categoryId = value;
    } else if (field == 'adModelAddress') {
      adsModel.address = value;
    }

    emit(MyAdsInitial());
  }

  Future<void> updateAdPropertyFunc() async {
    try {
      emit(PropertyUpdateAdLoading());

      // إنشاء النسخة المعدلة من PropertyAdModel
      await myAdsRepository.updateAdProperty(
        adsModel: adsModel,
      );

      //  print("🔵 PropertyUpdateAdCubit.updateAdProperty data: $updatedData");

      emit(PropertyUpdateAdSuccess());
    } on ServerException catch (e) {
      emit(PropertyUpdateAdFailure(errorMassage: e.errorModel.errorMessage));
    }
  }
}
