part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSearchChangerState extends HomeState {}

final class HomeAdsLoading extends HomeState {}

final class HomeAdsSuccess extends HomeState {}

final class HomeAdsFailure extends HomeState {
  final String errorMassage;

  HomeAdsFailure({required this.errorMassage});
}

final class HomeTextSearchAdsLoading extends HomeState {}

final class HomeTextSearchAdsSuccess extends HomeState {}

final class HomeTextSearchAdsFailure extends HomeState {
  final String errorMassage;

  HomeTextSearchAdsFailure({required this.errorMassage});
}
