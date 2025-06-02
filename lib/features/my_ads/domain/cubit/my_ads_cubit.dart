import 'package:bloc/bloc.dart';
import 'package:emtelek/core/errors/exceptions.dart';
import 'package:emtelek/features/add_property_listing/data/models/property_add_model.dart';
import 'package:emtelek/features/my_ads/data/models/ad_model.dart';
import 'package:emtelek/features/my_ads/data/models/delete_ad_request_model.dart';
import 'package:emtelek/features/my_ads/data/models/get_my_ads_response_model.dart';
import 'package:emtelek/features/my_ads/data/repositories/my_ads_repository.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';

import 'package:emtelek/shared/models/add-ads-models/add_ad_model.dart';
import 'package:emtelek/shared/models/all_response.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
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

  List<AdModel> myAds = [];
  List<GetMyAdsResponseModel> myAdsX = [];
  Future<void> getMyAds() async {
    emit(GetMyAdsLoading());
    try {
      final response = await myAdsRepository.getMyAds(
        tokenAndClintIdRequestModel: TokenAndClintIdRequestModel(
          token: getIt<CacheHelper>().getDataString(key: 'token')!,
          clientId: getIt<CacheHelper>().getData(key: 'clientId'),
        ),
      );
      print('response----------------------: ${response.length}  ');
      myAdsX = response;
      print('myAdsX----------------------: ${myAdsX.length}  ');

      emit(GetMyAdsSuccess());
    } catch (e) {
      print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
      emit(GetMyAdsFailure(errorMassage: e.toString()));
    }
  }

  // late AdModel adModel;

  // void setEditIndex({required int index}) {
  //   print('index: $index');
  //   editIndex = index;

  //   adModel = AdModel(
  //     token: getIt<CacheHelper>().getDataString(key: 'token')!,
  //     adId: myAds[editIndex].adId,
  //     adTitle: myAds[editIndex].adTitle,
  //     price: myAds[editIndex].price,
  //     currency: myAds[editIndex].currency,
  //     description: myAds[editIndex].description,
  //     location: myAds[editIndex].location,
  //     publishDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
  //     status: 5,
  //     sellerType: myAds[editIndex].sellerType,
  //     categoryId: myAds[editIndex].categoryId,
  //     clientId: myAds[editIndex].clientId,
  //     features: myAds[editIndex].features,
  //     images: myAds[editIndex].images,
  //     client: myAds[editIndex].client,
  //     city: myAds[editIndex].city,
  //     district: myAds[editIndex].district,
  //     isFavorite: myAds[editIndex].isFavorite,
  //     info: AdInfoModel(
  //       totalArea: myAds[editIndex].info!.totalArea,
  //       netArea: myAds[editIndex].info!.netArea,
  //       roomCount: myAds[editIndex].info!.roomCount,
  //       floorNumber: myAds[editIndex].info!.floorNumber,
  //       floorCount: myAds[editIndex].info!.floorCount,
  //       bathroomCount: myAds[editIndex].info!.bathroomCount,
  //       constructionDate: myAds[editIndex].info!.constructionDate,
  //       address: myAds[editIndex].info!.address,
  //       balconyCount: myAds[editIndex].info!.balconyCount,
  //       complexName: myAds[editIndex].info!.complexName,
  //       furnish: myAds[editIndex].info!.furnish,
  //     ),
  //   );

  //   emit(MyAdsInitial());
  // }

  // void updatePropertyField(String field, dynamic value) {
  //   switch (field) {
  //     case 'totalArea':
  //       adModel.info!.totalArea = value;
  //       break;
  //     case 'netOrBuildingArea':
  //       adModel.info!.netArea = value;
  //       break;
  //     case 'roomCount':
  //       adModel.info!.roomCount = value;
  //       break;
  //     case 'bathroomCount':
  //       adModel.info!.bathroomCount = value;
  //       break;
  //     case 'floorCount':
  //       adModel.info!.floorCount = value;
  //       break;
  //     case 'floorNumber':
  //       adModel.info!.floorNumber = value;
  //       break;
  //     case 'balconyCount':
  //       adModel.info!.balconyCount = value;
  //       break;
  //     case 'constructionDate':
  //       adModel.info!.constructionDate = value;
  //       break;
  //     case 'furnished':
  //       adModel.info!.furnish = value;
  //       break;
  //     case 'complexName':
  //       adModel.info!.complexName = value;
  //       break;
  //     case 'adModelTitle':
  //       adModel.adTitle = value;
  //       break;
  //     case 'adModelPrice':
  //       adModel.price = value;
  //       break;
  //     case 'adModelLocation':
  //       adModel.location = value;
  //       break;
  //     case 'adModelDescription':
  //       adModel.description = value;
  //       break;
  //     case 'adModelPhone':
  //       adModel.client!.phoneNumber = value;
  //       break;
  //     case 'adModelCurrency':
  //       adModel.currency = value;
  //       break;
  //     case 'adModelEmail':
  //       adModel.client!.email = value;
  //       break;
  //     // case 'adModelDistrictId':
  //     //   adModel.districtId = value;
  //     //   break;
  //     case 'adModelClientId':
  //       adModel.clientId = value;
  //       break;
  //     case 'adModelSellerType':
  //       adModel.sellerType = value;
  //       break;
  //     case 'adModelCategoryId':
  //       adModel.categoryId = value;
  //       break;
  //     case 'adModelAddress':
  //       adModel.info!.address = value;
  //       break;
  //     case 'adModelCity':
  //       adModel.city = value;
  //       break;
  //     case 'adModelDistrict':
  //       adModel.district = value;
  //       break;
  //     case 'adModelIsFavorite':
  //       adModel.isFavorite = value;
  //       break;
  //     case 'adModelFeatures':
  //       adModel.features = value;
  //       break;
  //     case 'adModelImages':
  //       adModel.images = value;
  //       break;
  //   }

  //   emit(MyAdsInitial());
  // }

  Future<void> deleteAdProperty(
      {required DeleteAdRequestModel deleteAdRequestModel}) async {
    try {
      emit(PropertyDeleteAdLoading());

      // إنشاء النسخة المعدلة من PropertyAdModel
      final response = await myAdsRepository.deleteAdProperty(
        deleteAdRequestModel: deleteAdRequestModel,
      );
      if (response.status != 'success') {
        PropertyDeleteAdFailure(errorMassage: response.msg!);
      }

      emit(PropertyDeleteAdSuccess());
    } on ServerException catch (e) {
      emit(PropertyDeleteAdFailure(errorMassage: e.errorModel.errorMessage));
    }
  }
}
