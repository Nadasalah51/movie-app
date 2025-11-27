import 'dart:convert';
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/feature/details/data/model/details_model.dart';
import 'package:movie_app/feature/details/data/model/similar_model.dart';

abstract class DetailsApi {
  static Future<ResultAPI<DetailsModel>> getMovieDetails(int id) async {
    //api.themoviedb.org/3/movie/1033462?api_key=a03a5441a50487cfc0416c45cd853d40
    Uri url = Uri.https(
      AppConstApi.baseUrl,
      '${AppConstApi.detailsEndPoint}$id',
      {'api_key': AppConstApi.apiKey},
    );
    try {
      var response = await http.get(url);
      String responseBody = response.body;
      var json = jsonDecode(responseBody);
      var data = DetailsModel.fromJson(json);
      return SuccessAPI<DetailsModel>(data: data);
    } catch (e) {
      return ErrorAPI<DetailsModel>(messageError: e.toString());
    }
  }

  static Future<ResultAPI<SimilarModel>> getSimilarMovies(int id) async {
    // api.themoviedb.org/3/movie/1419406/similar?api_key=a03a5441a50487cfc0416c45cd853d40
    Uri url = Uri.https(
      AppConstApi.baseUrl,
      '${AppConstApi.detailsEndPoint}$id${AppConstApi.similarEndPoint}',
      {'api_key': AppConstApi.apiKey},
    );
    try {
      var response = await http.get(url);
      String responseBody = response.body;
      var json = jsonDecode(responseBody);
      var data = SimilarModel.fromJson(json);
      return SuccessAPI<SimilarModel>(data: data);
    } catch (e) {
      return ErrorAPI<SimilarModel>(messageError: e.toString());
    }
  }
}
