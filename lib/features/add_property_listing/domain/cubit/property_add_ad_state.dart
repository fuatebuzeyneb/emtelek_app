part of 'property_add_ad_cubit.dart';

@immutable
sealed class PropertyAddAdState {}

final class PropertyAddAdInitial extends PropertyAddAdState {}

final class PropertyAddOrUpdateAdLoading extends PropertyAddAdState {}

final class PropertyAddAdSuccess extends PropertyAddAdState {}

final class PropertyUpdateAdSuccess extends PropertyAddAdState {}

final class PropertyAddOrUpdateAdFailure extends PropertyAddAdState {
  final String errorMassage;

  PropertyAddOrUpdateAdFailure({required this.errorMassage});
}

final class FeaturesAddAdInitial extends PropertyAddAdState {}

final class FeaturesAddAdLoading extends PropertyAddAdState {}

final class FeaturesAddAdSuccess extends PropertyAddAdState {}

final class FeaturesAddAdFailure extends PropertyAddAdState {
  final String errorMassage;

  FeaturesAddAdFailure({required this.errorMassage});
}
