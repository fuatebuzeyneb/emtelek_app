part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class UserDataLoading extends ProfileState {}

final class UserDataFailure extends ProfileState {
  final String errorMassage;

  UserDataFailure({required this.errorMassage});
}

final class GetAccountSettingsSuccess extends ProfileState {}

final class EditAccountSettingsSuccess extends ProfileState {}

final class DeleteAccountSettingsSuccess extends ProfileState {}

class CheckPassLoading extends ProfileState {}

class CheckPassSuccess extends ProfileState {}

class CheckPassFailure extends ProfileState {
  final String errorMassage;
  CheckPassFailure({required this.errorMassage});
}

class ChangePassLoading extends ProfileState {}

class ChangePassSuccess extends ProfileState {}

class ChangePassFailure extends ProfileState {
  final String errorMassage;
  ChangePassFailure({required this.errorMassage});
}
