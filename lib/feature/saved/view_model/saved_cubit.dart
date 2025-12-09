import 'package:bloc/bloc.dart';
import 'package:movie_app/feature/saved/data/database/sql_database.dart';
import 'package:movie_app/feature/saved/data/model/saved_model.dart';
import 'package:movie_app/feature/saved/view_model/saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(InitialState()) {
    getSavedMovies();
  }
  Future<void> getSavedMovies() async {
    emit(LoadingState());
    try {
      final List<SavedModel> result = await SqlHelper().loadMovie();
      if (result.isEmpty) {
        emit(EmptyState());
      } else {
        emit(SuccessState(movies: result));
      }
    } catch (e) {
      emit(Errorstate(message: e.toString()));
    }
  }
}
