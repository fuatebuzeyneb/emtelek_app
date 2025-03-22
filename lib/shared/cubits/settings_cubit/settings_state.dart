part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsBottomSheetValue extends SettingsState {
  SettingsBottomSheetValue();
}

class CityLoading extends SettingsState {}

class CityLoaded extends SettingsState {}

class CityError extends SettingsState {
  final String message;
  CityError(this.message);
}
