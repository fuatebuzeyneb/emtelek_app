import 'package:emtelek/shared/models/add-ads-models/add_ad_model.dart';

class PropertyAdModel {
  AddAdModel adModel;
  int? totalArea;
  int? netOrBuildingArea;
  int? roomCount;
  int? bathroomCount;
  int? floorCount;
  int? floorNumber;
  int? balconyCount;
  DateTime? constructionDate;
  bool? furnished; //If we add to the land, this means that it contains trees
  String? complexName;

  PropertyAdModel({
    required this.adModel,
    required this.totalArea,
    this.netOrBuildingArea,
    this.roomCount,
    this.bathroomCount,
    this.floorCount,
    this.floorNumber,
    this.balconyCount,
    this.constructionDate,
    this.furnished = false,
    this.complexName,
  });

  factory PropertyAdModel.fromJson(Map<String, dynamic> json) {
    return PropertyAdModel(
      adModel: AddAdModel.fromJson(json),
      totalArea: json["totalArea"],
      netOrBuildingArea: json["netOrBuildingArea"],
      roomCount: json["roomCount"],
      bathroomCount: json["bathroomCount"],
      floorCount: json["floorCount"],
      floorNumber: json["floorNumber"],
      balconyCount: json["balconyCount"],
      constructionDate: json["constructionDate"],
      furnished: json["furnished"],
      complexName: json["complexName"],
    );
  }

  Map<String, dynamic> toJson() => {
        ...adModel.toJson(),
        "TotalArea": totalArea,
        "NetArea": netOrBuildingArea,
        "RoomCount": roomCount,
        "BathroomCount": bathroomCount,
        "FloorCount": floorCount,
        "FloorNumber": floorNumber,
        "BalconyCount": balconyCount,
        "ConstructionDate": constructionDate,
        "Furnish": furnished,
        "ComplexName": complexName,
      };

  @override
  String toString() {
    return 'PropertyAdModel('
        'adModel: $adModel, '
        'totalArea: $totalArea, '
        'netOrBuildingArea: $netOrBuildingArea, '
        'roomCount: $roomCount, '
        'bathroomCount: $bathroomCount, '
        'floorCount: $floorCount, '
        'floorNumber: $floorNumber, '
        'balconyCount: $balconyCount, '
        'constructionDate: $constructionDate, '
        'furnished: $furnished, '
        'complexName: $complexName)';
  }
}
