import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/search/data/model/search_model.dart';

class ApiSearch {
  static Future<ResultAPI<SearchModel>> getSearchData(String query) async {
    Uri url = Uri.https(AppConstApi.baseUrl, AppConstApi.searchEndPoint, {
      "query": query,
      "api_key": AppConstApi.apiKey,
    });

    try {
      var response = await http.get(url);
      String responseBody = response.body;
      var json = jsonDecode(responseBody);
      var data = SearchModel.fromJson(json);
      return SuccessAPI<SearchModel>(data: data);
    } catch (e) {
      return ErrorAPI<SearchModel>(messageError: e.toString());
    }
  }
}
