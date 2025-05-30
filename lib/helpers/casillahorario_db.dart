import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:proyecto/helpers/jsonserializable_interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    
    dynamic path;

    if(Platform.isWindows || Platform.isLinux) {
      path = join((await getApplicationDocumentsDirectory()).path, 'app_pool.db');
    } else {
      path = join(await getDatabasesPath(), 'app_pool.db');
    }
    
    
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return _db!;
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE casillahorario (
        id INTEGER PRIMARY KEY,
        dia INTEGER,
        horaini TEXT,
        horafin TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE clase (
        id INTEGER PRIMARY KEY,
        idcoach INTEGER,
        idcasilla INTEGER,
        idcurso INTEGER,
        coach TEXT,
        casillahorario TEXT,
        curso TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE cuenta (
        id INTEGER PRIMARY KEY,
        nombreusu TEXT,
        password TEXT,
        password_hashed TEXT,
        avatar TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE curso (
        id INTEGER PRIMARY KEY,
        curso TEXT,
        descripcion TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE domicilio (
        id INTEGER PRIMARY KEY,
        calle TEXT,
        numext INTEGER,
        numint INTEGER,
        asentamiento TEXT,
        codigop INTEGER,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE historial (
        id INTEGER PRIMARY KEY,
        idusuario INTEGER,
        idpaquete INTEGER,
        fechaini DATETIME,
        fechafin DATETIME,
        metodo TEXT,
        paquete TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE horario (
        id INTEGER PRIMARY KEY,
        idusuario INTEGER,
        idclase INTEGER,
        clase TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE metricas (
        id INTEGER PRIMARY KEY,
        estatura REAL,
        peso REAL,
        maxcardio REAL,
        maxpulso INTEGER,
        frecuenciasemanal INTEGER,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE paquete (
        id INTEGER PRIMARY KEY,
        precio REAL,
        clases INTEGER,
        flexible TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE personales (
        id INTEGER PRIMARY KEY,
        nombre TEXT,
        apellidop TEXT,
        apellidom TEXT,
        email TEXT,
        telefono TEXT,
        tipodocumento TEXT,
        documento TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE subscripcion (
        id INTEGER PRIMARY KEY,
        idusuario INTEGER,
        idpaquete INTEGER,
        estado TEXT,
        fechaini DATETIME,
        fechafin DATETIME,
        renovarauto TEXT,
        paquete TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE usuario (
        id INTEGER PRIMARY KEY,
        idpersonales INTEGER,
        iddomicilio INTEGER,
        idcuenta INTEGER,
        idmetricas INTEGER,
        tipousuario INTEGER,
        personales TEXT,
        cuenta TEXT,
        metricas TEXT,
        domicilio TEXT,
        subscripcion TEXT,
        horario TEXT,
        clases TEXT,
        historial TEXT,
        sync_status INTEGER DEFAULT 0
      );
    ''');
  }

  static Future<void> insert<T extends JsonSerializable>(T obj) async {
    final db = await getDatabase();
    await db.insert(
      obj.tablename,
      obj.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<T>> getAll<T extends JsonSerializable>({
    required String tableName,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return maps.map((map) => fromJson(map)).toList();
  }

  static Future<void> delete(String tablename, int id) async {
    final db = await getDatabase();
    await db.delete(tablename, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update<T extends JsonSerializable>(T obj) async {
    final db = await getDatabase();
    await db.update(
      obj.tablename,
      obj.toJson(),
      where: 'id = ?',
      whereArgs: [obj.id],
    );
  }

  static Future<void> updatePartial(
      String tableName, int id, Map<String, dynamic> fields) async {
    final db = await getDatabase();
    await db.update(
      tableName,
      fields,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

extension JsonExtension<T extends JsonSerializable> on T {
  Map<String, Object?> toJson() {
    return this.toJson();
  }
}
