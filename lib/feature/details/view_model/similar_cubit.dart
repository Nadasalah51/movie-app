import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/api/details_api.dart';
import 'package:movie_app/feature/details/data/model/similar_model.dart';
import 'package:movie_app/feature/details/view_model/similar_state.dart';

class SimilarCubit extends Cubit<SimilarState> {
  SimilarCubit() : super(InitialSimilarState());

  Future<void> getSimilarMovies(int id) async {
    emit(LoadingSimilarState());
    final result = await DetailsApi.getSimilarMovies(id);

    switch (result) {
      case SuccessAPI<SimilarModel>():
        emit(SuccessSimilarState(result.data?.results ?? []));
      case ErrorAPI<SimilarModel>():
        emit(ErrorSimilarState(result.messageError));
    }
  }
}
