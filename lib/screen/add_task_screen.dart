import 'package:daily_routine_planner/controllers/task_controller.dart';
import 'package:daily_routine_planner/models/taskmodels.dart';
import 'package:daily_routine_planner/screen/home_screen.dart';
import 'package:daily_routine_planner/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _noteControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime="9:30 PM";
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  List<String> rapreadList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor = 0;
  @override

  Widget build(BuildContext context) {
    print(_selectedColor);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Task"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyInputField(title:"Title",hint: "Enter your title", controller: _titleControler,),
              MyInputField(title:"Note",hint: "Enter your note", controller: _noteControler, ),
              MyInputField(title:"Date",hint:DateFormat.yMd().format(_selectedDate),
                widget: IconButton(onPressed: (){
                  _showDatePicker();
                }, icon: Icon(Icons.calendar_month,color: Colors.white,)),
              ),
              Row(
                children: [
                  Expanded(child: MyInputField(title:"Start Time",hint:_startTime, controller: null,
                    widget: IconButton(onPressed: (){
                      _getTimePickerUserFrom(isStartTime:true);
                    }, icon: Icon(Icons.schedule,color: Colors.white,)),
                  ),),
                  SizedBox(width: 5,),
                  Expanded(child: MyInputField(title:"End Time",hint:_endTime,
                    widget: IconButton(onPressed: (){
                      _getTimePickerUserFrom(isStartTime:false);
                    }, icon: Icon(Icons.schedule,color: Colors.white,)),
                  ),),
                ],
              ),
              MyInputField(title:"Remind",hint: "$_selectedRemind minites early",
                widget: DropdownButton(
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                  underline: Container(height: 0,),
                  icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem(
                        value:value.toString(),
                        child: Text(value.toString())
                    );
                  } ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRemind =int.parse(value!);
                    });
                  },

                ),
              ),
              MyInputField(title:"Repeat",hint: "$_selectedRepeat",
                widget: DropdownButton(
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                  underline: Container(height: 0,),
                  icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  items: rapreadList.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem(
                        value:value.toString(),
                        child: Text(value.toString())
                    );
                  } ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRepeat =value!;
                    });
                  },

                ),
              ),
              SizedBox(width: 20,),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                      Wrap(
                        children: List<Widget>.generate(3, (int index) {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                _selectedColor=index;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child:  CircleAvatar(
                                radius: 14,
                                backgroundColor:index==0?Colors.indigo:index==1?Colors.pinkAccent:Colors.amber,
                                child: _selectedColor==index?Icon(Icons.done,color: Colors.white,):null,
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                  OutlinedButton(onPressed: (){
                    validateDate();
                  }, child: Text("ADD TASK"))
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
  validateDate()async{
    if(_titleControler.text.isNotEmpty && _noteControler.text.isNotEmpty){
      await _addTastDB();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }else if(_titleControler.text.isEmpty || _noteControler.text.isEmpty){
      Get.snackbar("Required", 'All Fields are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.pinkAccent,
        icon: Icon(Icons.warning_amber_outlined,color: Colors.red,)
      );
    }
  }
  _addTastDB()async{
  int value = await _taskController.AddTask(
        taskModels: TaskModels(
            title: _titleControler.text,
            note: _noteControler.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isCompleted: 0
        ),

    );
  print("My id is $value");


  }

  void _showDatePicker() async{
    DateTime? _DatePicker= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));
    if(_DatePicker!=null){
      setState((){
        _selectedDate=_DatePicker;
      });
    }else{
      print("null ");
    }

  }
  _getTimePickerUserFrom({required bool isStartTime})async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time cancel");
    }else if(isStartTime==true){
      setState(() {
        _startTime=_formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime=_formatedTime;
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
