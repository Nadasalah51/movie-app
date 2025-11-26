import 'package:movie_app/features/home/data/model/release_model.dart';

abstract class ReleaseState {}

class InitialState extends ReleaseState {}

class LoadingState extends ReleaseState {}

class SucessState extends ReleaseState {
  List<Results> results = [];
  SucessState(this.results);
}

class ErrorState extends ReleaseState {
  ErrorState(this.error);
  final String error;
}
