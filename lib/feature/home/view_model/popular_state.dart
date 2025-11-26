import 'package:movie_app/features/home/data/model/Popular_model.dart';

abstract class PopularState {}

class InitialState extends PopularState {}

class LoadingState extends PopularState {}

class SucessState extends PopularState {
  List<Results> results = [];
  SucessState(this.results);
}

class ErrorState extends PopularState {
  ErrorState(this.error);
  final String error;
}
