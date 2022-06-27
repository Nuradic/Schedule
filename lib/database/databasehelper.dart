import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'model_schedule.dart';

class DatabaseHelper {
  final scheduleTableName = "mySchedule";
  final chapTableName = "chapter";
  final dateTableName = "dateTime";
  final weekTable = "week";

  static final DatabaseHelper instance = DatabaseHelper.init();
  DatabaseHelper.init();
  factory DatabaseHelper() => instance;
  Database? _database;

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    Directory mydir = await getApplicationDocumentsDirectory();
    String mypath = join(mydir.path, 'schedule.db');
    return await openDatabase(version: 1, mypath, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
    db.execute(
        'CREATE TABLE $scheduleTableName (id INTEGER PRIMARY KEY, subject TEXT, date INTEGER NOT NULL)');
  }

  //Performing  Crud opeartion of on Database
  Future<List<Map<String, dynamic>>> getMaplist({required tableName}) async {
    Database db = await database;
    return await db.query(tableName, orderBy: "id ASC");
  }

  Future<List<Schedule>> getScheduleList() async {
    List<Map<String, dynamic>> myMaps =
        await getMaplist(tableName: scheduleTableName);
    List<Schedule> mySchedule = [];
    for (int i = 0; i < myMaps.length; i++) {
      mySchedule.add(Schedule.fromMap(myMaps[i]));
    }
    return mySchedule;
  }

  Future<int> insertSchedule(Schedule schedule) async {
    Database db = await database;
    return db.insert("schedule", Schedule.toMap(schedule));
  }

  Future<int> updateSchedule(Schedule schedule) async {
    Database db = await database;
    return await db.update(scheduleTableName, Schedule.toMap(schedule),
        where: "id= ?", whereArgs: [schedule.id]);
  }

  Future<int> deleteSchedule(Schedule schedule) async {
    Database db = await database;
    return await db
        .delete(scheduleTableName, where: "id= ?", whereArgs: [schedule.id]);
  }
}
