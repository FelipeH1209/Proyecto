import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? _database;

class LocalDatabase {
  Future get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Local.db');
    return _database;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
        CREATE TABLE users( id INTEGER PRIMARY KEY AUTOINCREMENT, 
                            name VARCHAR(255), 
                            email VARCHAR(100)
                          )
      ''');
  }

  Future addDataLocally({Name}) async {
    final db = await database;
    await db.insert('users', {"name": Name});
    print('${Name} Agregado exitosamente');
    return "added";
  }

  Future readUser({name, password}) async {
    final db = await database;
    final data = await db!.rawQuery(
        'SELECT * FROM "users" WHERE name = ${name} AND password = ${password}');
    print(data);
    return 'data';
  }
}
