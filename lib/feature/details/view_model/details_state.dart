import 'package:movie_app/feature/details/data/model/details_model.dart';

abstract class DetailsState {}

class InitialDetailsState extends DetailsState {}

class LoadingDetailsState extends DetailsState {}

class SuccessDetailsState extends DetailsState {
  SuccessDetailsState(this.movieDetails);
  DetailsModel movieDetails;
}

class ErrorDetailsState extends DetailsState {
  ErrorDetailsState(this.errorMessage);
  final String errorMessage;
}
