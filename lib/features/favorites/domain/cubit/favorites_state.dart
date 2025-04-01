part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesFailure extends FavoritesState {
  final String errorMassage;
  FavoritesFailure({required this.errorMassage});
}

final class FavoritesSuccess extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}
