part of 'property_cubit.dart';

@immutable
sealed class PropertyState {}

final class PropertyInitial extends PropertyState {}

final class PropertyFilterAreaRange extends PropertyState {}

final class PropertyAdsFilterLoading extends PropertyState {}

final class PropertyAdsFilterSuccess extends PropertyState {}

final class PropertyAdsFilterFailure extends PropertyState {
  final String errMessage;
  PropertyAdsFilterFailure({required this.errMessage});
}
