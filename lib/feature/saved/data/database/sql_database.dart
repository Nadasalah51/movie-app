import 'package:movie_app/feature/saved/data/model/saved_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class SqlHelper {
  Database? database;
  static final SqlHelper _instance = SqlHelper._internal();

  factory SqlHelper() {
    return _instance;
  }

  SqlHelper._internal();
  getDatabase() async {
    if (database != null) {
      return database;
    } else {
      database = await intiDatabase();
      return database;
    }
  }

Future<Database> intiDatabase() async {
  String path = join(await getDatabasesPath(), 'movie.db');
  return await openDatabase(
    path,
    version: 3,
    onCreate: onCreate,
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute('DROP TABLE IF EXISTS saved');
        await onCreate(db, newVersion);
      }
    },
  );
}

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE saved (
      id Integer PRIMARY KEY, 
      title TEXT ,
      rate REAL DEFAULT 0,
      ticket Text,
      date Text,
      image Text
    )
    ''');
  }
  
  Future<int> addMovie(SavedModel newMovie) async {
    Database db = await getDatabase();
    return await db.insert('saved', newMovie.toMap());
  }

Future<bool> isMovieSaved(int movieId) async {
  Database db = await getDatabase();
  final List<Map<String, dynamic>> maps = await db.query(
    'saved',
    where: 'id = ?',
    whereArgs: [movieId],
  );
  return maps.isNotEmpty;
}
  Future<List<SavedModel>> loadMovie() async {
    Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('saved');
    return maps.map((map) => SavedModel.fromMap(map)).toList();
  }

  Future<void> deleteMovie(int id) async {
    Database db = await getDatabase();
    await db.delete('saved', where: 'id = ?', whereArgs: [id]);
  }
}
