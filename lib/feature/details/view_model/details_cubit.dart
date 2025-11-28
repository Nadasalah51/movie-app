import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/api/details_api.dart';
import 'package:movie_app/feature/details/data/model/details_model.dart';
import 'package:movie_app/feature/details/view_model/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(InitialDetailsState());

  Future<void> getDetailsFromAPI(int id) async {
    emit(LoadingDetailsState());
    final result = await DetailsApi.getMovieDetails(id);
    switch (result) {
      case SuccessAPI<DetailsModel>():
        emit(SuccessDetailsState(result.data ?? DetailsModel()));
      case ErrorAPI<DetailsModel>():
        emit(ErrorDetailsState(result.messageError));
    }
  }
}
