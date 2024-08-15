import 'dart:async';
// ignore: unused_import
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
                            password VARCHAR(50),
                            photo VARCHAR(50),
                            perfil INT(1)
                          )
      ''');

    await db.execute('''
        CREATE TABLE novillos( id INTEGER PRIMARY KEY AUTOINCREMENT,
                            pesoT VARCHAR(20),
                            estaturaT VARCHAR(20),
                            razaT VARCHAR(50),
                            generoT VARCHAR(50),
                            enfermedades VARCHAR(50),
                            medicamento VARCHAR(30),
                            categoria VARCHAR(25),
                            crias VARCHAR(10),
                            qr VARCHAR(100)
                          )
      ''');

    await db.insert('users', {
      "name": "Admin",
      "email": "admin@gmail.com",
      "password": "123456789",
      "photo": "admin.png",
      "perfil": "1",
    });
  }

  Future readUser({email, password}) async {
    final db = await database;

    final List data = await db!.rawQuery(
        "SELECT * FROM users WHERE email = '${email}' AND password = '${password}'");
    if (!data.isEmpty) {
      var user = data[0];
      return {
        "name": user['name'],
        "email": user['email'],
        "photo": user['photo'],
        "perfil": user['perfil']
      };
    }
    return {};
  }

  Future getUserById({id}) async {
    final db = await database;
    final List data =
        await db!.rawQuery("SELECT * FROM users WHERE id = '${id}'");
    if (!data.isEmpty) {
      var user = data[0];
      return {
        "name": user['name'],
        "email": user['email'],
        "photo": user['photo'],
        "perfil": user['perfil'].toString()
      };
    }
    return {};
  }

  Future readAllUser() async {
    final db = await database;
    var users = <Map>[];
    final List data = await db!.rawQuery("SELECT * FROM users");
    if (!data.isEmpty) {
      for (var i = 0; i < data.length; i++) {
        var user = data[i];
        var json = <String, Object>{
          "id": user['id'],
          "name": user['name'],
          "email": user['email'],
          "photo": user['photo'],
          "perfil": user['perfil'].toString(),
        };
        users.add(json);
      }
      return users;
    }
    return {};
  }

  Future insertUser({name, email, password, perfil}) async {
    var photo = perfil == '1' ? "admin.png" : "operator.png";
    final db = await database;
    await db.insert('users', {
      "name": name,
      "email": email,
      "password": password,
      "photo": photo,
      "perfil": perfil,
    });
    return {};
  }

  Future updateUser({id, name, email, password, perfil}) async {
    var photo = perfil == '1' ? "admin.png" : "operator.png";
    final db = await database;
    await db!.rawQuery("""
      UPDATE users SET 
        name = '${name}',
        email = '${email}',
        password = '${password}',
        photo = '${photo}',
        perfil = '${perfil}'
      WHERE id = '${id}'""");
    return {};
  }

  Future deleteUser({id}) async {
    final db = await database;
    await db!.rawQuery("DELETE FROM users WHERE id = ${id}");
  }

  Future addnovi(pesoT, estaturaT, razaT, generoT, enfermedades, medicamento,
      categoria, crias, qr) async {
    final db = await database;
    await db.insert('novillos', {
      "pesoT": pesoT,
      "estaturaT": estaturaT,
      "razaT": razaT,
      "generoT": generoT,
      "enfermedades": enfermedades,
      "medicamento": medicamento,
      "categoria": categoria,
      "crias": crias,
      "qr": qr
    });
    return true;
  }

  // Future addDataLocally({Name}) async {
  //   final db = await database;
  //   await db.insert('users', {"name": Name});
  //   print('${Name} Agregado exitosamente');
  //   return "added";
  // }
}
