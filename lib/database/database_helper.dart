import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
//    WHEN CREATING DB CREATEE TABLE
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY,firstName TEXT,latsName TEXT,dob TEXT)");
  }

  Future<int> SaveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  Future<List<User>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    List<User> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user =
      new User(list[i]["firstname"], list[i]["lastname"], list[i]["dob"]);
      user.setUserId(list[i]["id"]);
      employees.add(user);
    }
    print(employees.length);
    return employees;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res =
    await dbClient.rawDelete('DELETE FROM User WHERE id = ?, [user.id]');
    return res;
  }

  Future<bool> updateUser(User user) async {
    var dbClient = await db;
    int res = await dbClient
        .update("User", user.toMap(), where: "id=?", whereArgs: <int>[user.id]);
    return res > 0 ? true : false;
  }
}
