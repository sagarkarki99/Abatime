import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _createQuery =
    "CREATE TABLE movies_table(id INTEGER PRIMARY KEY, title TEXT, year INTEGER, rating INTEGER, imageUrl TEXT)";

Future<Database> _getDatabase() async =>
    openDatabase(join(await getDatabasesPath(), 'abaTime_database.db'),
        onCreate: (db, version) => db.execute(_createQuery), version: 1);

Future<void> insert({dynamic data, String tableName}) async {
  assert(tableName != null);
  assert(data != null);
  Database database = await _getDatabase();
  database.insert('$tableName', data,
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<dynamic> retrieve({String tableName}) async {
  assert(tableName != null);
  final Database database = await _getDatabase();
  final List<Map<String, dynamic>> maps = await database.query('$tableName');
  return maps;
}

Future<void> delete(int id, String tableName) async {
  Database database = await _getDatabase();
 final index = await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
 print('Response is $index');
}
