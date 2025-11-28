import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/model/Popular_model.dart';

class PopulardApi {
  static Future<dynamic> getMovie() async {
    Uri url = Uri.https(AppConstApi.baseUrl,AppConstApi.popularEndPoint,
        {'api_key':AppConstApi.apiKey});
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      var data = PoPularModel.fromJson(json);
      return SuccessAPI<PoPularModel>(data: data);
    } catch (e) {
      return ErrorAPI<PoPularModel>(messageError: e.toString());
    }
  }
}
