import 'dart:convert';
import '../../../../core/network/result_api.dart' show ResultAPI, SuccessAPI, ErrorAPI;
import 'package:http/http.dart' as http;
import '../model/recommendation_model.dart' show RecommendationModel;

class RecommendationApi {
  static Future<ResultAPI<RecommendationModel>> getDataRecommendation()async{
    Uri url = Uri.https('api.themoviedb.org','/3/movie/top_rated',{
      'api_key':'a03a5441a50487cfc0416c45cd853d40',
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