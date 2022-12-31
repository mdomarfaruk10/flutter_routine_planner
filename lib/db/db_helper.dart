
import 'package:daily_routine_planner/models/taskmodels.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? _db;
  static final _version = 2;
  static final String _tableName = "tasks";

  static Future<void> initDB()async{
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db,version){
          print("create a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
                "title STRING, note STRING, date STRING,"
                "startTime STRING,endTime STRING,"
                "remind INTEGER, repeat STRING,"
                "color INTEGER,"
                "isCompleted INTEGER)"
          );
        }
      );
    }catch(e){
      print(e);

    }
  }
  static Future<int> insert(TaskModels? taskModels) async{
    print('insert function called');
    return await _db?.insert(_tableName, taskModels!.toJson())??1;
  }
  static Future<List<Map<String,dynamic>>> query() async{
    print('get database');
    return await _db!.query(_tableName);
  }

  static void delete(TaskModels taskList)async{
    _db!.delete(_tableName, where: "id=?", whereArgs: [taskList.id]);
  }

  static update(int id) async{
   return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
    ''',[1,id]);
  }

}