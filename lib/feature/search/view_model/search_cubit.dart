import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/search/data/api/api_search.dart';
import 'package:movie_app/feature/search/data/model/search_model.dart';
import 'package:movie_app/feature/search/view_model/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialState());
  Future<void> searchMovies(String query) async {
    emit(LoadingState()); 
    final result = await ApiSearch.getSearchData(query);
    switch(result){
      case SuccessAPI<SearchModel>():
            if (result.data == null) {
        emit(ErrorState(message: result.toString()));
        return;
    }
      final bool isEmpty = result.data?.results?.isEmpty ?? true;
      emit(SuccsessState(
        searchData: result.data,
        isEmpty: isEmpty,
      ));
      case ErrorAPI<SearchModel>():
       emit(ErrorState(message:result.messageError));
    }
  }
}


