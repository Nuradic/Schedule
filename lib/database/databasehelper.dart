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
  final dateName = "date";

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
    String mypath = join(mydir.path, 'schedules13.db');
    return await openDatabase(version: 1, mypath, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
///////////////////////////Schedule table/////////////////////////////////
    db.execute(
        '''CREATE TABLE $scheduleTableName (sid INTEGER PRIMARY KEY AUTOINCREMENT,cid INTEGER NOT NULL, did INTEGER NOT NULL, subject TEXT)''');
//////////////////////////date time table////////////////////////////////
    db.execute('''CREATE TABLE $dateTableName(
        did INTEGER PRIMARY KEY AUTOINCREMENT,shour INTEGER NOT NULL,sminute INTEGER NOT NULL,ehour INTEGER NOT NULL,eminute INTEGER NOT NULL,date INTEGER NOT NULL,weekId INTEGER NOT NULL)''');

///////////////////////////Start and end date//////////////////////////////
    db.execute('''
CREATE TABLE $dateName( date INTEGER PRIMARY KEY AUTOINCREMENT,
sday INTEGER NOT NULL, smonth INTEGER NOT NULL,
syear INTEGER NOT NULL, eday INTEGER NOT NULL,
emonth INTEGER NOT NULL, eyear INTEGER NOT NULL)
''');
///////////////////////////chapter table///////////////////////////////////
    db.execute('''
CREATE TABLE $chapTableName(cid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT )
''');
//////////////////////////week table///////////////////////////////////////
    db.execute('''
CREATE TABLE $weekTable(
weekId INTEGER PRIMARY KEY AUTOINCREMENT, sunday  INTEGER NOT NULL, monday  INTEGER NOT NULL, tuesday  INTEGER NOT NULL, wednesday  INTEGER NOT NULL, thursday  INTEGER NOT NULL, friday  INTEGER NOT NULL, saturday  INTEGER NOT NULL )''');
  }

  //Performing  Crud opeartion of on Database
  Future<List<Map<String, dynamic>>> getMaplist(
      {required tableName, required id}) async {
    Database db = await database;
    return await db.query(tableName, orderBy: "$id ASC");
  }

////////////////////////////////////////////////////////////////////////////////
  Future<List<Schedule>> getScheduleList() async {
    List<Schedule> mySchedule = [];
    // List<List<Map<String, dynamic>>> myListMap = [];
    List<Map<String, dynamic>> sciListMap =
        await getMaplist(tableName: scheduleTableName, id: 'sid');
    List<Map<String, dynamic>> chapListMap =
        await getMaplist(tableName: chapTableName, id: 'cid');
    List<Map<String, dynamic>> dateTimeListMap =
        await getMaplist(tableName: dateTableName, id: 'did');
    List<Map<String, dynamic>> dateListMap =
        await getMaplist(tableName: dateName, id: 'date');
    List<Map<String, dynamic>> weekListMap =
        await getMaplist(tableName: weekTable, id: 'weekId');

    // print(value);
    for (int i = 0; i < sciListMap.length; i++) {
      List<Map<String, dynamic>> tempListMap = [
        sciListMap[i],
        dateTimeListMap[i],
        chapListMap[i],
        dateListMap[i],
        weekListMap[i]
      ];

      mySchedule.add(Schedule.fromMap(tempListMap));
    }

    return mySchedule;
  }

  Future<int> insertSchedule(Schedule schedule) async {
    Database db = await database;
    List<Map<String, dynamic>> listMap = Schedule.listMap(schedule);
    listMap[4]['weekId'] = await db.insert(weekTable, listMap[4]);
    listMap[3][" date"] = await db.insert(dateName, listMap[3]);
    listMap[2]["cid"] = await db.insert(chapTableName, listMap[2]);
    //// inserting ids to other tables
    listMap[1][" date"] = listMap[3][" date"];
    listMap[1]["weekId"] = listMap[4]["weekId"];
    listMap[1]["did"] = await db.insert(dateTableName, listMap[1]);
    listMap[0]["cid"] = listMap[2]["cid"];
    listMap[0]["did"] = listMap[1]["did"];

    return await db.insert(scheduleTableName, listMap[0]);
  }

  Future<int> updateSchedule(Schedule schedule) async {
    Database db = await database;
    List<Map<String, dynamic>> listMap = Schedule.listMap(schedule);
    await db.update(weekTable, listMap[4],
        where: "weekId= ?", whereArgs: [schedule.weekId]);
    await db.update(dateName, listMap[3],
        where: " date= ?", whereArgs: [schedule.date]);
    await db.update(dateTableName, listMap[2],
        where: "did= ?", whereArgs: [schedule.did]);
    await db.update(chapTableName, listMap[1],
        where: "cid= ?", whereArgs: [schedule.cid]);
    return await db.update(scheduleTableName, listMap[0],
        where: "sid= ?", whereArgs: [schedule.sid]);
  }

  Future<int> deleteSchedule(Schedule schedule) async {
    Database db = await database;
    await db.delete(dateName, where: " date= ?", whereArgs: [schedule.date]);
    await db.delete(dateTableName, where: "did= ?", whereArgs: [schedule.did]);
    await db.delete(chapTableName, where: "cid= ?", whereArgs: [schedule.cid]);
    await db
        .delete(weekTable, where: "weekId= ?", whereArgs: [schedule.weekId]);
    return await db
        .delete(scheduleTableName, where: "sid= ?", whereArgs: [schedule.sid]);
  }
}
