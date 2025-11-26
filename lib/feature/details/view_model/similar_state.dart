import 'package:movie_app/feature/details/data/model/similar_model.dart';

abstract class SimilarState {}

class InitialState extends SimilarState {}

class LoadingState extends SimilarState {}

class SuccessState extends SimilarState {
  SuccessState(this.similarMoviesResult);
  List<Results> similarMoviesResult;
}

class ErrorState extends SimilarState {
  ErrorState(this.errorMessage);
  final String errorMessage;
}
