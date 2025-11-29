
import 'package:movie_app/feature/saved/data/model/saved_model.dart';

abstract class SavedState {}

class InitialState extends SavedState {}

class EmptyState extends SavedState {}

class LoadingState extends SavedState {}

class SuccessState extends SavedState {
  final List<SavedModel> movies;
  SuccessState({required this.movies});
}

class Errorstate extends SavedState {
  final String message;
  Errorstate({required this.message});
}
