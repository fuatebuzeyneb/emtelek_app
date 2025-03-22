part of 'property_add_ad_cubit.dart';

@immutable
sealed class PropertyAddAdState {}

final class PropertyAddAdInitial extends PropertyAddAdState {}

final class PropertyAddAdLoading extends PropertyAddAdState {}

final class PropertyAddAdSuccess extends PropertyAddAdState {}

final class PropertyAddAdFailure extends PropertyAddAdState {
  final String errorMassage;

  PropertyAddAdFailure({required this.errorMassage});
}
