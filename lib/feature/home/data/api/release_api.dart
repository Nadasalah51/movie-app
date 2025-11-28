// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:movie_app/core/network/result_api.dart';
// import 'package:movie_app/features/home/data/model/release_model.dart';

// class ReleaseApi {
//   static Future<dynamic> getMovie() async {
//     Uri url = Uri.https('api.themoviedb.org', '/3/movie/upcoming',
//         {'api_key': "9d7f94be913eddf2db40e317d2f12f36"});
//     try {
//       var response = await http.get(url);
//       var json = jsonDecode(response.body);
//       var data = Release_model.fromJson(json);
//       return SuccessAPI<Release_model>(data: data);
//     } catch (e) {
//       return ErrorAPI<Release_model>(messageError: e.toString());
//     }
//   }
// }
// //api.themoviedb.org/3/movie/upcoming?api_key=9d7f94be913eddf2db40e317d2f12f36
