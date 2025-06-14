part of 'property_filter_cubit.dart';

@immutable
sealed class PropertyFilterState {}

final class PropertyFilterInitial extends PropertyFilterState {}

final class PropertyFilterAreaRange extends PropertyFilterState {}

final class PropertyFilterLoading extends PropertyFilterState {}

final class PropertyFilterSuccess extends PropertyFilterState {}

final class PropertyFilterFailure extends PropertyFilterState {
  final String errMessage;
  PropertyFilterFailure({required this.errMessage});
}

final class GetSearchFilterSuccess extends PropertyFilterState {}

final class GetSearchFilterLoading extends PropertyFilterState {}

final class GetSearchFilterFailure extends PropertyFilterState {
  final String errMessage;
  GetSearchFilterFailure({required this.errMessage});
}
