import 'package:movie_app/feature/details/data/model/details_model.dart';

class SavedModel {
  int id;
  String title;
  String ticket;
  String date;
  String image;
  double rate;
  SavedModel({
    required this.id,
    required this.date,
    required this.ticket,
    required this.image,
    required this.rate,
    required this.title,
  });

  factory SavedModel.fromMap(Map<String, dynamic> map) {
    return SavedModel(
      id: map['id'],
      title: map['title'],
      rate: map['rate'],
      ticket: map['ticket'],
      date: map['date'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rate': rate,
      'ticket': ticket,
      'date': date,
      'image': image,
    };
  }

  DetailsModel get toModel => DetailsModel(
    id: id,
    releaseDate: date,
    originalLanguage: ticket,
    title: title,
  );
}
