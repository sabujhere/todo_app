import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todo.dart';

class DbHelper {

  static final DbHelper _dbHelper = DbHelper._internal();
  String tblTodo = "todo";
  String colId = "id";
  String colPriority ="priority";
  String colTitle = "title";
  String colDescription = "description";
  String colDate = "date";

  DbHelper._internal();
  factory DbHelper()  {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      "CREATE Table $tblTodo($colId INTEGER PRIMARY KEY, $colTitle TEXT, " +
        "$colDescription TEXT, $colPriority INTEGER, $colDate TEXT"
    );
  }

}