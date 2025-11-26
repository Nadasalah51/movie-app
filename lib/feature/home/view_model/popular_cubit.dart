import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/features/home/data/api/popular_api.dart';
import 'package:movie_app/features/home/data/model/Popular_model.dart';

import 'package:movie_app/features/home/view_model/popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit() : super(InitialState());
  List<Results>? results = [];

  Future<void> getMovies() async {
    emit(LoadingState());
    final result = await PopulardApi.getMovie();
    switch (result) {
      case SuccessAPI<PoPularModel>():
        emit(SucessState(result.data?.results ?? []));

      case ErrorAPI<PoPularModel>():
        emit(ErrorState(result.messageError));
    }
  }
}
