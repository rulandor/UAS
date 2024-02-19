
import 'package:tugas_crud_unsia/model/member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

/**
 * Nama: Rulando Rahadiyan Rendragraha
 * NIM: 220101020026
 * Kelas: SI702
 * Mata Kuliah: Pemrograman Berbasis Perangkat Bergerak
 */

class DbHelperMember {
  static final DbHelperMember _instance = DbHelperMember._internal();
  static Database? _database;

  final String tableName = 'tableMahasiswa';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnNohp = 'nohp';
  final String columnAlamat = 'alamat';
  final String columnUmur = 'umur';

  DbHelperMember._internal();
  factory DbHelperMember() => _instance;

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
    String path = join(databasePath, 'member.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // create table
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT," "$columnNohp TEXT," "$columnAlamat TEXT,"
        "$columnUmur TEXT)";
    await db.execute(sql);
  }

  // insert
  Future<int?> saveMember(Member member) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, member.toMap());
  }

  // read
  Future<List?> getAllMember() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId, columnNama, columnNohp, columnAlamat, columnUmur
    ]);

    return result.toList();
  }

  //update
  Future<int?> updateMember(Member member) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, member.toMap(), where: '$columnId = ?', whereArgs: [member.id]);
  }

  //delete
  Future<int?> deleteMember(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}