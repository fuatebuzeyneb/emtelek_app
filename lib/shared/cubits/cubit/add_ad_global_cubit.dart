import 'package:bloc/bloc.dart';
import 'package:emtelek/shared/common_pages/select_location.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'add_ad_global_state.dart';

class AddAdGlobalCubit extends Cubit<AddAdGlobalState> {
  AddAdGlobalCubit() : super(AddAdGlobalInitial());

  int? cityId;

  void changeCityId({required int id}) {
    cityId = id;
    emit(AddAdGlobalInitial());
  }

  int? districtId;

  void changeDistrictId({required int id}) {
    districtId = id;
    emit(AddAdGlobalInitial());
  }

  String currencyId = 'USD';

  void changeCurrencyId({required String id}) {
    currencyId = id;
    emit(AddAdGlobalInitial());
  }

  int? sellerType;

  void changeSellerType({required int type}) {
    sellerType = type;
    emit(AddAdGlobalInitial());
  }

  String? location;

  void selectLocation({required String locationCome}) {
    location = locationCome;
    emit(AddAdGlobalInitial());
  }

  LatLng parseLatLng(String locationString) {
    List<String> coordinates = locationString.split(",");
    double latitude = double.parse(coordinates[0].trim());
    double longitude = double.parse(coordinates[1].trim());
    return LatLng(latitude, longitude);
  }
}
