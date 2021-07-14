import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'equipos.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE equipos(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,item1 TEXT NOT NULL , item2 TEXT NOT NULL,item3 TEXT NOT NULL, item4 TEXT NOT NULL,item5 TEXT NOT NULL,item6 TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<dynamic> insertEquipo(Map<String,dynamic> data) async {
    final Database db = await initializeDB();
      var result = await db.insert('equipos', data);
    return result;
  }

  Future<List<Map>> retrieveEquipos() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('users');
    return queryResult;
  }
}