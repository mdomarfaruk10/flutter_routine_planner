import 'package:daily_routine_planner/db/db_helper.dart';
import 'package:daily_routine_planner/models/taskmodels.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TaskController extends GetxController{

  var taskList = <TaskModels>[].obs;
  @override
  void onReady(){
    super.onReady();
  }
  Future<int> AddTask({TaskModels? taskModels})async{
    return await DBHelper.insert(taskModels);
  }
  void getTask()async{
    List<Map<String,dynamic>> task =await DBHelper.query();
    // taskList.assignAll(items)
  }
}