
import 'package:tugas_crud_unsia/model/instruktur.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class DbHelperInstruktur {
  static final DbHelperInstruktur _instance = DbHelperInstruktur._internal();
  static Database? _database;

  final String tableName = 'tableInstruktur';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnNohp = 'nohp';

  DbHelperInstruktur._internal();
  factory DbHelperInstruktur() => _instance;

  //cek apakah database ada
  Future<Database?> get _db  async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'instruktur.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // create table
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT," "$columnNohp TEXT)";
    await db.execute(sql);
  }

  // insert
  Future<int?> saveInstruktur(Instruktur instruktur) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, instruktur.toMap());
  }

  // read
  Future<List?> getAllInstruktur() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId, columnNama, columnNohp
    ]);

    return result.toList();
  }

  //update
  Future<int?> updateInstruktur(Instruktur instruktur) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, instruktur.toMap(), where: '$columnId = ?', whereArgs: [instruktur.id]);
  }

  //delete
  Future<int?> deleteInstruktur(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}