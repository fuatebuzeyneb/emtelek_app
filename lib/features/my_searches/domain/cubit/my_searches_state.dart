part of 'my_searches_cubit.dart';

@immutable
sealed class MySearchesState {}

final class MySearchesInitial extends MySearchesState {}

final class GetMySearchesSuccess extends MySearchesState {}

final class DeleteMySearchesSuccess extends MySearchesState {}

final class MySearchesLoading extends MySearchesState {}

final class MySearchesFailure extends MySearchesState {
  final String errMessage;
  MySearchesFailure({required this.errMessage});
}
