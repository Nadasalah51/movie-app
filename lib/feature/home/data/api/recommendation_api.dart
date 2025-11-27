import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/model/recommendation_model.dart';

class RecommendationApi {
  static Future<ResultAPI<RecommendationModel>> getDataRecommendation()async{
    Uri url = Uri.https(AppConstApi.baseUrl,AppConstApi.recommendationEndPoint,{
      'api_key':AppConstApi.apiKey,
    });
    try{
      var response = await http.get(url);
      String responseBody = response.body;
      var json = jsonDecode(responseBody);
      var data= RecommendationModel.fromJson(json);
      return SuccessAPI<RecommendationModel>(data: data);
    }catch(e){
      return ErrorAPI<RecommendationModel>(messageError: e.toString(),);

    }
  }
}