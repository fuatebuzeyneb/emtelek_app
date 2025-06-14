import 'package:bloc/bloc.dart';
import 'package:emtelek/core/errors/exceptions.dart';
import 'package:emtelek/features/add_property_listing/data/models/add_property_ad_request_model.dart';
import 'package:emtelek/features/add_property_listing/data/repositories/property_repository.dart';
import 'package:emtelek/features/home/data/models/property_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'property_add_ad_state.dart';

class PropertyAddAdCubit extends Cubit<PropertyAddAdState> {
  PropertyAddAdCubit(this.propertyRepository) : super(PropertyAddAdInitial());
  final PropertyRepository propertyRepository;
  // 6--> Property for buy
// 5--> Property for rent

  int? categoryForAdType;

  void changeCategoryForAdType(int type) {
    categoryForAdType = type;
    emit(PropertyAddAdInitial());
  }

  int? roomCount;
  int? bathroomCount;
  int? floorCount;
  int? floorNumber;
  int? balconyCount;

  void setPropertyCount(String field, int count) {
    if (field == 'roomCount') {
      roomCount = count;
    }
    if (field == 'bathroomCount') {
      bathroomCount = count;
    }
    if (field == 'floorCount') {
      floorCount = count;
    }
    if (field == 'floorNumber') {
      floorNumber = count;
    }
    if (field == 'balconyCount') {
      balconyCount = count;
    }

    emit(PropertyAddAdInitial());
  }

  List<int> featuresListId = [];
  List<FeatureModel> features = [];

  Future<void> getFeatures() async {
    try {
      emit(FeaturesAddAdLoading());
      final data = await propertyRepository.getFeatures();
      features = data;
      emit(FeaturesAddAdSuccess());
    } on ServerException catch (e) {
      emit(FeaturesAddAdFailure(errorMassage: e.errorModel.errorMessage));
    }
  }

  void toggleFeatureIdList({required int featureId}) {
    if (featuresListId.contains(featureId)) {
      featuresListId.remove(featureId);
    } else {
      featuresListId.add(featureId);
    }

    emit(PropertyAddAdInitial());
  }

  bool? furnishStatus;

  void changeFurnishStatus({required bool furnishOrNot}) {
    furnishStatus = furnishOrNot;
    emit(PropertyAddAdInitial());
  }

  DateTime? constructionDate;

  void changeConstructionDate({DateTime? date}) {
    constructionDate = date;
    emit(PropertyAddAdInitial());
  }

  //just for testing
  List<XFile> imagesProperty = [];
  XFile? mainImage;

  void addImagesWithMain({
    required List<XFile> allImages,
    required int mainImageIndex,
  }) {
    imagesProperty =
        List<XFile>.from(allImages); // احفظ كل الصور بما فيها الصورة الرئيسية
    mainImage = allImages[mainImageIndex]; // احفظ الصورة الرئيسية

    emit(PropertyAddAdInitial());
  }

  // PropertyAdModel propertyAdModel = PropertyAdModel(
  //     totalArea: null,
  //     netOrBuildingArea: null,
  //     roomCount: null,
  //     bathroomCount: null,
  //     floorCount: null,
  //     floorNumber: null,
  //     balconyCount: null,
  //     constructionDate: null,
  //     furnished: null,
  //     complexName: null,
  //     features: [],
  //     adModel: AddAdModel(
  //       title: null,
  //       price: null,
  //       location: null,
  //       image: null,
  //       description: null,
  //       phone: null,
  //       currency: 'USD',
  //       email: null,
  //       districtId: null,
  //       clientId: getIt<CacheHelper>().getData(key: 'clientId')!,
  //       sellerType: null,
  //       categoryId: null,
  //       token: getIt<CacheHelper>().getDataString(key: 'token')!,
  //       address: null,
  //     ));

  // List<int> selectedFeatures = [];
  // late AdModel adModel = AdModel(
  //   price: null,
  //   location: null,
  //   description: '',
  //   currency: 'USD',
  //   clientId: getIt<CacheHelper>().getData(key: 'clientId')!,
  //   sellerType: null,
  //   categoryId: null,
  //   token: getIt<CacheHelper>().getDataString(key: 'token')!,
  //   adId: null,
  //   adTitle: null,
  //   // publishDate: null,
  //   featureIds: selectedFeatures,
  //   client: ClientModel(
  //     clientId: null,
  //     phoneNumber: null,
  //     email: null,
  //     firstName: null,
  //     lastName: null,
  //     subscriptionDate: null,
  //     image: null,
  //     verified: null,
  //   ),
  //   district: DistrictModel(districtId: null),
  //   info: AdInfoModel(
  //       totalArea: null,
  //       netArea: '',
  //       roomCount: null,
  //       floorNumber: null,
  //       floorCount: null,
  //       bathroomCount: null,
  //       furnish: null,
  //       constructionDate: null,
  //       address: null,
  //       balconyCount: null,
  //       complexName: null),
  // );

  // void setPropertyField(String field, dynamic value) {
  //   if (field == 'totalArea') {
  //     adModel.info.totalArea = value;
  //   } else if (field == 'netOrBuildingArea') {
  //     adModel.info.netArea = value;
  //   } else if (field == 'roomCount') {
  //     adModel.info.roomCount = value;
  //   } else if (field == 'bathroomCount') {
  //     adModel.info.bathroomCount = value;
  //   } else if (field == 'floorCount') {
  //     adModel.info.floorCount = value;
  //   } else if (field == 'floorNumber') {
  //     adModel.info.floorNumber = value;
  //   } else if (field == 'balconyCount') {
  //     adModel.info.balconyCount = value;
  //   } else if (field == 'constructionDate') {
  //     adModel.info.constructionDate = value;
  //   } else if (field == 'furnished') {
  //     adModel.info.furnish = value;
  //   } else if (field == 'complexName') {
  //     adModel.info.complexName = value;
  //   } else if (field == 'adModelTitle') {
  //     adModel.adTitle = value;
  //   } else if (field == 'adModelPrice') {
  //     adModel.price = value;
  //   } else if (field == 'adModelLocation') {
  //     adModel.location = value;
  //   } else if (field == 'adModelImage') {
  //     adModel.images = value;
  //   } else if (field == 'adModelDescription') {
  //     adModel.description = value;
  //   } else if (field == 'adModelPhone') {
  //     adModel.client.phoneNumber = value;
  //   } else if (field == 'adModelCurrency') {
  //     adModel.currency = value;
  //   } else if (field == 'adModelEmail') {
  //     adModel.client.email = value;
  //   } else if (field == 'adModelDistrictId') {
  //     adModel.district.districtId = value;
  //   } else if (field == 'adModelClientId') {
  //     adModel.client.clientId = value;
  //   } else if (field == 'adModelSellerType') {
  //     adModel.sellerType = value;
  //   } else if (field == 'adModelCategoryId') {
  //     adModel.categoryId = value;
  //   } else if (field == 'adModelAddress') {
  //     adModel.info.address = value;
  //   } else if (field == 'adModelToken') {
  //     adModel.token = value;
  //   } else if (field == 'featuresAdd') {
  //     selectedFeatures.add(value);
  //   } else if (field == 'featuresRemove') {
  //     selectedFeatures.remove(value);
  //   }
  //   print('addAdModel: $adModel');
  //   emit(PropertyAddAdInitial());
  // }

  // void addFeatures({required int featuresId}) {
  //  setPropertyField('features', featuresId);
  //   emit(PropertyAddAdInitial());

  // }

  Future<void> addAdPropertyFunc(
      {required AddPropertyAdRequestModel addPropertyAdRequestModel}) async {
    emit(PropertyAddOrUpdateAdLoading());
    try {
      // تأكد من أن قائمة الصور لا تكون فارغة

      await propertyRepository.addAdProperty(
        images: imagesProperty,
        mainImage: mainImage!,
        featureIdList: featuresListId,
        addPropertyAdRequestModel: addPropertyAdRequestModel,
      );

      //   print("🔵 PropertyAddAdCubit.addAdProperty data: $data");

      emit(PropertyAddAdSuccess());
    } on ServerException catch (e) {
      print("🔵 PropertyAddAdCubit.addAdProperty e1: $e");
      emit(PropertyAddOrUpdateAdFailure(
          errorMassage: e.errorModel.errorMessage));
    } catch (e) {
      print("🔵 PropertyAddAdCubit.addAdProperty e2: $e");
      emit(PropertyAddOrUpdateAdFailure(errorMassage: e.toString()));
    }
  }

  Future<void> editAdPropertyFunc(
      {required AddPropertyAdRequestModel addPropertyAdRequestModel}) async {
    emit(PropertyAddOrUpdateAdLoading());
    try {
      print("🔵 1111");
      // تأكد من أن قائمة الصور لا تكون فارغة

      await propertyRepository.editAdProperty(
        images: imagesProperty,
        mainImage: mainImage!,
        featureIdList: featuresListId,
        addPropertyAdRequestModel: addPropertyAdRequestModel,
      );

      emit(PropertyUpdateAdSuccess());
    } on ServerException catch (e) {
      emit(PropertyAddOrUpdateAdFailure(
          errorMassage: e.errorModel.errorMessage));
      print(
          "🔵 PropertyAddAdCubit.addAdProperty errorMassage1: ${e.errorModel.errorMessage}");
    } catch (e) {
      emit(PropertyAddOrUpdateAdFailure(errorMassage: e.toString()));
      print(
          "🔵 PropertyAddAdCubit.addAdProperty errorMassage2: ${e.toString()}");
    }
  }
}
