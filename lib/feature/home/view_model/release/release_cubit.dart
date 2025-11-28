import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie-app/core/network/result_api.dart';
import 'package:movie-app/feature/home/data/api/home_api.dart';
import 'package:movie-app/feature/home/data/model/release_model.dart';
import 'package:movie-app/feature/home/view_model/release/release_state.dart';

class ReleaseCubit extends Cubit<ReleaseState> {
  ReleaseCubit() : super(InitialState());

  Future<void> getMovies() async {
    emit(LoadingState());
    final result = await HomeApi.getMovieRelease();

    switch (result) {
      case SuccessAPI<Release_model>():
        emit(SucessState(result.data?.results ?? []));

      case ErrorAPI<Release_model>():
        emit(ErrorState(result.messageError));
    }
  }
}
