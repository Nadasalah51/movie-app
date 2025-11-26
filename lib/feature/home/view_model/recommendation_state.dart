import 'package:movie_app/feature/home/data/model/recommendation_model.dart';

abstract class RecommendationState{}
class InitialRecommendationState extends RecommendationState{}
class LoadingRecommendationState extends RecommendationState{}
class SuccessRecommendationState extends RecommendationState{
  SuccessRecommendationState(this.results);
  List<Results> results;
}
class ErrorRecommendationState extends RecommendationState{
  ErrorRecommendationState(this.error);
  final String error;
}