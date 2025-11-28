import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/model/release_model.dart';

class ReleaseApi {
  static Future<dynamic> getMovie() async {
    Uri url = Uri.https(AppConstApi.baseUrl, AppConstApi.realesedEndPoint,
        {'api_key':AppConstApi.apiKey});
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      var data = ReleaseModel.fromJson(json);
      return SuccessAPI<ReleaseModel>(data: data);
    } catch (e) {
      return ErrorAPI<ReleaseModel>(messageError: e.toString());
    }
  }
}
