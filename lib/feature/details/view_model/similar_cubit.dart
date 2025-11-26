import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/api/similar_api.dart';
import 'package:movie_app/feature/details/data/model/similar_model.dart';
import 'package:movie_app/feature/details/view_model/similar_state.dart';

class SimilarCubit extends Cubit<SimilarState> {
  SimilarCubit() : super(InitialState());

  Future<void> getSimilarMovies(int id) async {
    emit(LoadingState());
    final result = await SimilarApi.getSimilarMovies(id);

    switch (result) {
      case SuccessAPI<SimilarModel>():
        emit(SuccessState(result.data?.results ?? []));
      case ErrorAPI<SimilarModel>():
        emit(ErrorState(result.messageError));
    }
  }
}
