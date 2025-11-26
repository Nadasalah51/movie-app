import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/features/home/data/api/release_api.dart';
import 'package:movie_app/features/home/data/model/release_model.dart';
import 'package:movie_app/features/home/view_model/release_state.dart';

class ReleaseCubit extends Cubit<ReleaseState> {
  ReleaseCubit() : super(InitialState());

  Future<void> getMovies() async {
    emit(LoadingState());
    final result = await ReleaseApi.getMovie();

    switch (result) {
      case SuccessAPI<Release_model>():
        emit(SucessState(result.data?.results ?? []));

      case ErrorAPI<Release_model>():
        emit(ErrorState(result.messageError));
    }
  }
}
