// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:movie_app/core/network/result_api.dart';
// import 'package:movie_app/features/home/data/model/Popular_model.dart';

// class PopulardApi {
//   static Future<dynamic> getMovie() async {
//     Uri url = Uri.https('api.themoviedb.org', '/3/movie/popular',
//         {'api_key': "9d7f94be913eddf2db40e317d2f12f36"});
//     try {
//       var response = await http.get(url);
//       var json = jsonDecode(response.body);
//       var data = PoPularModel.fromJson(json);
//       return SuccessAPI<PoPularModel>(data: data);
//     } catch (e) {
//       return ErrorAPI<PoPularModel>(messageError: e.toString());
//     }
//   }
// }
