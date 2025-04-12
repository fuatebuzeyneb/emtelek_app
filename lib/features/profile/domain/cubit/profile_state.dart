part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetAccountSettingsLoading extends ProfileState {}

final class GetAccountSettingsSuccess extends ProfileState {}

final class GetAccountSettingsFailure extends ProfileState {
  final String errorMassage;

  GetAccountSettingsFailure({required this.errorMassage});
}

final class EditAccountSettingsLoading extends ProfileState {}

final class EditAccountSettingsSuccess extends ProfileState {}

final class EditAccountSettingsFailure extends ProfileState {
  final String errorMassage;

  EditAccountSettingsFailure({required this.errorMassage});
}
