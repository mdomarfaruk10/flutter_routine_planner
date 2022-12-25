
import 'package:daily_routine_planner/models/taskmodels.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? _db;
  static final _version = 1;
  static final String _tableName = "Tasks";

  static Future<void> initDB()async{
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'task.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db,version){
          print("create a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING, note STRING, date STRING,"
                "startTime STRING,endTime STRING"
                "remind INTEGER, repead STRING"
                "color INTEGER"
                "isCompleted INTEGER"
          );
        }
      );
    }catch(e){
      print(e);

    }
  }
  static Future<int> insert(TaskModels? taskModels) async{
    print('create a database');
    return await _db?.insert(_tableName, taskModels!.toJson())??1;
  }
  static Future<List<Map<String,dynamic>>> query() async{
    print('get database');
    return await _db!.query(_tableName);
  }

}