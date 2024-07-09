import 'dart:ffi';

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
    print('aqui va la inicializacion de base de datos');
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    await db.execute("DROP TABLE IF EXISTS users");
    await db.execute('''
        CREATE TABLE users( id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name VARCHAR(255),
                            email VARCHAR(100),
                            password VARCHAR(50)
                          )
      ''');
    await db.insert('users',
        {"name": "Admin", "email": "admin@gmail.com", "password": "123456789"});
  }

  Future readUser({email, password}) async {
    final db = await database;
    await db.insert('users',
        {"name": "Admin", "email": "admin@gmail.com", "password": "123456789"});
    final List data = await db!.rawQuery(
        "SELECT * FROM users WHERE email = '${email}' AND password = '${password}'");
    if (!data.isEmpty) {
      return true;
    }
    return false;
  }

  Future _createNo(Database db, int version) async {
    await db.execute('''
        CREATE TABLE novillo( id INTEGER PRIMARY KEY AUTOINCREMENT,
                            pesoT VARCHAR(20),
                            estaturaT VARCHAR(20),
                            razaT VARCHAR(50),
                            generoT VARCHAR(50)
                          )
      ''');
    await db.insert('novillo', {
      "pesoT": "Admin",
      "email": "admin@gmail.com",
      "password": "123456789"
    });
  }

  Future addnovi() async {
    final db = await database;
    await db.insert('novillo', {
      "pesoT": String,
      "estaturaT": Float,
      "razaT": String,
      "generoT": String
    });
    return 'agregado';
  }

  // Future addDataLocally({Name}) async {
  //   final db = await database;
  //   await db.insert('users', {"name": Name});
  //   print('${Name} Agregado exitosamente');
  //   return "added";
  // }
}
