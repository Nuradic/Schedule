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
    String mypath = join(mydir.path, 'schedule.db');
    return await openDatabase(version: 1, mypath, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) {
///////////////////////////Schedule table/////////////////////////////////
    db.execute('''CREATE TABLE $scheduleTableName (
        sid INTEGER PRIMARY KEY AUTOINCREMENT, 
        cid INTEGER NOT NULL,
        did INTEGER NOT NULL,
        subject TEXT, 
        )
        ''');
//////////////////////////date time table////////////////////////////////
    db.execute('''CREATE TABLE $dateTableName(
        did INTEGER PRIMARY KEY AUTOINCREMENT,
        hour INTEGER NOT NULL,
        minute INTEGER NOT NULL,
        date INTEGER NOT NULL,
        weekId INTEGER NOT NULL,
        )
        ''');

///////////////////////////Start and end date//////////////////////////////
    db.execute('''
CREATE TABLE $dateName(stid INTEGER PRIMARY KEY AUTOINCREMENT,
sday INTEGER NOT NULL,
smonth INTEGER NOT NULL,
syear INTEGER NOT NULL,
eday INTEGER NOT NULL,
emonth INTEGER NOT NULL,
eyear INTEGER NOT NULL,)
''');
///////////////////////////chapter table///////////////////////////////////
    db.execute('''
CREATE TABLE $chapTableName(cid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT )
''');
//////////////////////////week table///////////////////////////////////////
    db.execute('''
CRAETE TABLE $weekTable(
weekId INTEGER PRIMARY KEY AUTOINCREMENT,
sunday BOLEAN NOT NULL,
monday BOLEAN NOT NULL,
tuesday BOLEAN NOT NULL,
wednesday BOLEAN NOT NULL,
thursday BOLEAN NOT NULL,
friday BOLEAN NOT NULL,
saturday BOLEAN NOT NULL
)''');
  }

  //Performing  Crud opeartion of on Database
  Future<List<Map<String, dynamic>>> getMaplist({required tableName}) async {
    Database db = await database;
    return await db.query(tableName, orderBy: "id ASC");
  }

////////////////////////////////////////////////////////////////////////////////
  Future<List<Schedule>> getScheduleList() async {
    List<Map<String, Map<String, dynamic>>> myMapMap = [];
    List<Map<String, dynamic>> sciListMap =
        await getMaplist(tableName: scheduleTableName);
    List<Map<String, dynamic>> chapListMap =
        await getMaplist(tableName: chapTableName);
    List<Map<String, dynamic>> dateTimeListMap =
        await getMaplist(tableName: dateTableName);
    List<Map<String, dynamic>> dateListMap =
        await getMaplist(tableName: dateName);
    List<Map<String, dynamic>> weekListMap =
        await getMaplist(tableName: weekTable);

    getMaplist(tableName: scheduleTableName).then((value) {
      for (int i = 0; i < value.length; i++) {
        Map<String, Map<String, dynamic>> tempMapMap = {
          "scTab": sciListMap[i],
          "chapter": chapListMap[i],
          "dateTimeTab": dateTimeListMap[i],
          "dateTab": dateListMap[i],
          "weekTab": weekListMap[i]
        };
        myMapMap.add(tempMapMap);
      }
    });
    List<Schedule> mySchedule = [];
    for (int i = 0; i < myMapMap.length; i++) {
      mySchedule.add(Schedule.fromMap(myMapMap[i]));
    }
    return mySchedule;
  }

  Future<int> insertSchedule(Schedule schedule) async {
    Database db = await database;
    int weekId = await db.insert(weekTable, schedule.whichDay);
    int stid = await db.insert(dateName, {
      "sday": schedule.startDate!.day,
      "smonth": schedule.startDate!.month,
      "syear": schedule.startDate!.year,
      "eday": schedule.startDate!.day,
      "emonth": schedule.startDate!.month,
      "eyear": schedule.startDate!.year,
    });
    int cid = await db.insert(chapTableName, {"chapter": schedule.chapter});

    int did = await db.insert(dateTableName, {
      "hour": schedule.startDate!.hour,
      "minute": schedule.startDate!.minute,
      "date": stid,
      "weekId": weekId
    });
    int sid = await db.insert(scheduleTableName,
        {"cid": cid, "did": did, "subject": schedule.subject});

    return sid;
    // db.insert("schedule", Schedule.toMap(schedule));
  }

  Future<int> updateSchedule(Schedule schedule) async {
    Database db = await database;
    return await db.update(scheduleTableName, Schedule.toMapMap(schedule),
        where: "id= ?", whereArgs: [schedule.id]);
  }

  Future<int> deleteSchedule(Schedule schedule) async {
    Database db = await database;
    return await db
        .delete(scheduleTableName, where: "id= ?", whereArgs: [schedule.id]);
  }
}
