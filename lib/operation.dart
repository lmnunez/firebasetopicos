import 'package:firebasetopicos/persona.dart';

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'personas.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE personas (id INTEGER PRIMARY KEY AutoIncrement, nombre TEXT, correo TEXT, celular TEXT)",
      );
    }, version: 1);
  }

  static Future<void> insert(Persona persona) async {
    Database database = await _openDB();

    return database.insert("personas", persona.toMap());
  }

  static Future<void> delete(Persona persona) async {
    Database database = await _openDB();

    return database.delete("personas", where: 'id = ?', whereArgs: [persona.id]);
  }

  static Future<void> update(Persona persona) async {
    Database database = await _openDB();

    return database.update("personas",persona.toMap(), where: 'id = ?', whereArgs: [persona.id]);
  }

  static Future<List<Persona>> personas() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> personasMap = await database.query("personas");

    for (var n in personasMap) {
      print("____" + n['nombre']);
    }

    return List.generate(
        personasMap.length,
        (i) => Persona(
            id: personasMap[i]['id'],
            nombre: personasMap[i]['nombre'],
            correo: personasMap[i]['correo'],
            celular: personasMap[i]['celular']));
  }
}
