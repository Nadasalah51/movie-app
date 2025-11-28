import 'package:movie_app/feature/home/data/model/popular_model.dart';

abstract class PopularState {}

class InitialState extends PopularState {}

class LoadingState extends PopularState {}

class SucessState extends PopularState {
  List<PopularResults> popularResult = [];
  SucessState(this.popularResult);
}

class ErrorState extends PopularState {
  ErrorState(this.error);
  final String error;
}
