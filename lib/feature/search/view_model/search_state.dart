import 'package:movie_app/feature/search/data/model/search_model.dart';

abstract class SearchState {}

class InitialState extends SearchState {}

class LoadingState extends SearchState {}

class SuccsessState extends SearchState {
  final SearchModel? searchData;
  final bool isEmpty;
  SuccsessState({required this.searchData, this.isEmpty = false});
}

class ErrorState extends SearchState {
  final String message;
  ErrorState({required this.message});
}
