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

final class SaveSearchPropertyFilterSuccess extends PropertyFilterState {}

final class SaveSearchPropertyFilterLoading extends PropertyFilterState {}

final class SaveSearchPropertyFilterFailure extends PropertyFilterState {
  final String errMessage;
  SaveSearchPropertyFilterFailure({required this.errMessage});
}
