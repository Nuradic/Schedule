// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   String? tableName;
//   List tabnames = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];

//   static final DatabaseHelper instance = DatabaseHelper.init();
//   DatabaseHelper.init();
//   factory DatabaseHelper() => instance;

//   Database? _database;
//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initiateDb();
//       return _database!;
//     } else {
//       return _database!;
//     }
//   }

//   Future<Database> initiateDb() async {
//     Directory mydir = await getApplicationDocumentsDirectory();
//     String mypath = join(mydir.path, 'MyTodo.db');
//     return openDatabase(mypath, version: 1, onCreate: _onCreate);
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     for (int i = 0; i < tabnames.length; i++) {
//       db.execute(
//           '''CREATE TABLE ${tabnames[i]}(id INTEGER PRIMARY KEY AUTOINCREMENT ,title TEXT NOT NULL,description TEXT NOT NULL,isChecked INTEGER NOT NULL)''');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getMapList({required tableName}) async {
//     Database db = await database;
//     return await db.query(tableName!, orderBy: 'id ASC');
//   }

//   Future<List<Todo>> listTodo({required tableName}) async {
//     var maplist = await getMapList(tableName: tableName);
//     List<Todo> temp = [];
//     maplist.forEach((value) {
//       temp.add(Todo.fromMap(value));
//     });
//     return temp;
//   }

//   Future<int> insertTodo({required Todo todo, required tableName}) async {
//     Database db = await database;
//     return await db.insert(tableName!, Todo.toMap(todo));
//   }

//   Future<int> updateTodo({required Todo todo, required tableName}) async {
//     Database db = await database;
//     return await db.update(tableName!, Todo.toMap(todo),
//         where: 'id= ?', whereArgs: [todo.id]);
//   }

//   Future<int> deleteTodo({required Todo todo, required tableName}) async {
//     Database db = await database;
//     return await db.delete(tableName!, where: "id= ?", whereArgs: [todo.id]);
//   }
// }

// class Todo {
//   int? id;
//   String? title;
//   String? description;
//   bool isChecked;
//   Todo(
//       {@required this.title,
//       @required this.description,
//       this.id,
//       this.isChecked = false});
//   static Map<String, dynamic> toMap(Todo todo) {
//     return {
//       if (todo.id != null) 'id': todo.id,
//       'title': todo.title,
//       'description': todo.description,
//       'isChecked': todo.isChecked ? 1 : 0,
//     };
//   }

//   static Todo fromMap(Map<String, dynamic> map) {
//     return Todo(
//         title: map['title'],
//         id: map['id'],
//         description: map['description'],
//         isChecked: map['isChecked'] == 1);
//   }
// }
