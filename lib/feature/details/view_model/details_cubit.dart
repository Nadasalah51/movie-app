import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/api/details_api.dart';
import 'package:movie_app/feature/details/data/model/details_model.dart';
import 'package:movie_app/feature/details/view_model/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(InitialState());

  Future<void> getDetailsFromAPI(int id) async {
    emit(LoadingState());
    final result = await DetailsApi.getMovieDetails(id);
    log('from no');
    switch (result) {
      case SuccessAPI<DetailsModel>():
        log('from succes');
        emit(SuccessState(result.data ?? DetailsModel()));
      case ErrorAPI<DetailsModel>():
        log('from error');
        emit(ErrorState(result.messageError));
    }
  }
}
