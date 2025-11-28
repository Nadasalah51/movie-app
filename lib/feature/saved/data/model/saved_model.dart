import 'package:movie_app/feature/search/data/model/search_model.dart';

class SavedModel {
  int id;
  String title;
  String ticket;
  String date;
  String image;
  int rate;
  SavedModel({
    required this.id,
    required this.date,
    required this.ticket,
    required this.image,
    required this.rate,
    required this.title,
  });

  Results get toModel =>
      Results(id: id, releaseDate: date, originalLanguage: ticket, title: title);
}
