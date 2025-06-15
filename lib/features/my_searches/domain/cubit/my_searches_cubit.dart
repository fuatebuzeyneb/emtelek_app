import 'package:bloc/bloc.dart';
import 'package:emtelek/features/my_ads/data/repositories/my_ads_repository.dart';
import 'package:emtelek/features/my_searches/data/models/delete_one_my_search_request_model.dart';
import 'package:emtelek/features/my_searches/data/repositories/my_searches_repository.dart';
import 'package:emtelek/features/my_searches/data/models/get_my_searches_response_model.dart';
import 'package:emtelek/shared/models/token_and_clint_id_request_model.dart';
import 'package:meta/meta.dart';

part 'my_searches_state.dart';

class MySearchesCubit extends Cubit<MySearchesState> {
  final MySearchesRepository mySearchesRepository;
  MySearchesCubit(this.mySearchesRepository) : super(MySearchesInitial());

  List<SearchFilterItemModel>? mySavedSearchFilterList;
  Future<void> getMySearches({
    required TokenAndClintIdRequestModel tokenAndClintIdRequestModel,
  }) async {
    emit(MySearchesLoading());

    try {
      final response = await mySearchesRepository.getMySearches(
        tokenAndClintIdRequestModel: tokenAndClintIdRequestModel,
      );

      if (response.data != null && response.data!.isNotEmpty) {
        mySavedSearchFilterList = response.data;
        emit(GetMySearchesSuccess());
      } else {
        emit(MySearchesFailure(errMessage: 'No saved filters found!'));
      }
    } catch (e) {
      emit(MySearchesFailure(errMessage: e.toString()));
    }
  }

  Future<void> deleteOneMySearch({
    required DeleteOneMySearchRequestModel deleteOneMySearchRequestModel,
  }) async {
    emit(MySearchesLoading());

    try {
      await mySearchesRepository.deleteOneMySearch(
        deleteOneMySearchRequestModel: deleteOneMySearchRequestModel,
      );

      emit(DeleteMySearchesSuccess());
      getMySearches(
          tokenAndClintIdRequestModel: TokenAndClintIdRequestModel(
              token: deleteOneMySearchRequestModel.token,
              clientId: deleteOneMySearchRequestModel.clientId));
    } catch (e) {
      emit(MySearchesFailure(errMessage: e.toString()));
    }
  }
}
