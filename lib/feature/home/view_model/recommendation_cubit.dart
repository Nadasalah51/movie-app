import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/api/recommendation_api.dart';
import 'package:movie_app/feature/home/view_model/recommendation_state.dart';
import '../data/model/recommendation_model.dart' show RecommendationModel;


class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit() : super(InitialRecommendationState());
  Future<void> getResults() async{
    emit(LoadingRecommendationState());
    final result = await RecommendationApi.getDataRecommendation();
    switch(result){
      case SuccessAPI<RecommendationModel>():
        emit(SuccessRecommendationState(result.data?.results ??[]));
      case ErrorAPI<RecommendationModel>():
        emit(ErrorRecommendationState(result.messageError));

    }
  }

}