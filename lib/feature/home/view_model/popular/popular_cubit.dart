import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/api/home_api.dart';
import 'package:movie_app/feature/home/data/model/popular_model.dart';
import 'package:movie_app/feature/home/view_model/popular/popular_state.dart';


class PopularCubit extends Cubit<PopularState> {
  
  PopularCubit() : super(InitialState());
  List<PopularResults>? results = [];

  Future<void> getMovies() async {
    emit(LoadingState());
    final result = await HomeApi.getMoviepopular();
    switch (result) {
      case SuccessAPI<PoPularModel>():
        emit(SucessState(result.data?.results ?? []));

      case ErrorAPI<PoPularModel>():
        emit(ErrorState(result.messageError));
    }
  }
}
