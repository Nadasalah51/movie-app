import 'dart:convert';
import 'package:movie_app/core/network/result_api.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/feature/details/data/model/similar_model.dart';

abstract class SimilarApi {
  static Future<ResultAPI<SimilarModel>> getSimilarMovies(int id) async {
    // api.themoviedb.org/3/movie/1419406/similar?api_key=a03a5441a50487cfc0416c45cd853d40
    Uri url = Uri.https('api.themoviedb.org', '3/movie/$id/similar', {
      'api_key': 'a03a5441a50487cfc0416c45cd853d40',
    });
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
