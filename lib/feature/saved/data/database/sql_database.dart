import 'package:movie_app/feature/saved/data/model/saved_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class SqlHelper {
  Database? database;

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
      version: 1,
      onCreate: onCreate,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    print("Database _onCreate: Creating 'product' table...");
    await db.execute('''
    CREATE TABLE saved (
      id Integer PRIMARY KEY , 
      title TEXT UNIQUE NOT NULL,
      rate REAL DEFAULT 0,
      ticket Text,
      date Text,
      image Text,
    )
    ''');
  }
     
    Future<int> addproduct(SavedModel newMovie) async {
    Database db = await getDatabase();
    return await db.insert('movie', newMovie.toModel as Map<String, Object?>);
  }

  Future<List<Map<String, dynamic>>> loadProduct() async {
    Database db = await getDatabase();
    return await db.query('movie');
  }

    Future<void> deleteMovie(int id) async {
    Database db = await getDatabase();
    await db.delete(
      'id',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}


