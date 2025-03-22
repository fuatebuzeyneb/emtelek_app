part of 'ad_details_cubit.dart';

@immutable
sealed class AdDetailsState {}

final class AdDetailsInitial extends AdDetailsState {}

final class ShowAppBarState extends AdDetailsState {}

final class DescriptionIsExpandedState extends AdDetailsState {}

final class ShowAllFeaturesState extends AdDetailsState {}

final class CurrentImageState extends AdDetailsState {}
