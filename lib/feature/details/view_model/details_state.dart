import 'package:movie_app/feature/details/data/model/details_model.dart';

abstract class DetailsState {}

class InitialState extends DetailsState {}

class LoadingState extends DetailsState {}

class SuccessState extends DetailsState {
  SuccessState(this.movieDetails);
  DetailsModel movieDetails;
}

class ErrorState extends DetailsState {
  ErrorState(this.errorMessage);
  final String errorMessage;
}
