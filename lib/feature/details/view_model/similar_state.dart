import 'package:movie_app/feature/details/data/model/similar_model.dart';

abstract class SimilarState {}

class InitialSimilarState extends SimilarState {}

class LoadingSimilarState extends SimilarState {}

class SuccessSimilarState extends SimilarState {
  SuccessSimilarState(this.similarMoviesResult);
  List<Results> similarMoviesResult;
}

class ErrorSimilarState extends SimilarState {
  ErrorSimilarState(this.errorMessage);
  final String errorMessage;
}
