import 'package:daily_routine_planner/component/stylesh_drawer.dart';
import 'package:daily_routine_planner/controllers/task_controller.dart';
import 'package:daily_routine_planner/models/taskmodels.dart';
import 'package:daily_routine_planner/screen/add_task_screen.dart';
import 'package:daily_routine_planner/services/notification_services.dart';
import 'package:daily_routine_planner/services_provider/Services_provider.dart';
import 'package:daily_routine_planner/widget/task_title_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final  _taskController = Get.put(TaskController());

  NotificationHelper notificationHelper =NotificationHelper();
  void initState(){
    super.initState();
    _taskController.getTask();


  }



  @override


  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notificationHelper.scheduleNotification();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
           // modalBottomSheetMenu(context);
        },
        child: Icon(Icons.app_registration_sharp),
      ),
      drawer: StyleshDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text("Routine Planner"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),style: GoogleFonts.lato(
                fontSize: 20,
                  fontWeight: FontWeight.w800,
              ),),
              Text("Today",style: GoogleFonts.lato(
                  fontSize: 20,
                fontWeight: FontWeight.w800
              ),),
              Container(
                margin: EdgeInsets.only(top: 10,left: 10),
                child: DatePicker(
                    height: 100,
                  DateTime.now(),
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.indigo,
                  selectedTextColor: Colors.white,
                  dateTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey
                  ),
                  dayTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey
                  ),
                  monthTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey
                  ),
                  onDateChange: (date){
                     setState(() {
                       _selectedDate = date;
                     });
                  },
                ),
              ),
              InkWell(child: Obx((){
                return ListView.builder(
                    itemCount: _taskController.taskList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context,index){
                      TaskModels taskList = _taskController.taskList[index];
                      print(taskList.toJson());
                      if(taskList.repeat=="Daily"){
                        DateTime date = DateFormat.jm().parse(
                            taskList.startTime.toString()

                        );
                        var myTime = DateFormat("HH:mm").format(date);
                        print(myTime);

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child:SlideAnimation(
                            child: FadeInAnimation(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      modalBottomSheetMenu(context,taskList);
                                    },
                                    child: TaskTitleWidget(taskList:taskList,),
                                  )
                                ],
                              ),
                            ),
                          ) ,
                        );
                      }
                      if(taskList.date==DateFormat.yMd().format(_selectedDate)){
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child:SlideAnimation(
                            child: FadeInAnimation(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      modalBottomSheetMenu(context,taskList);
                                    },
                                    child: TaskTitleWidget(taskList:taskList,),
                                  )
                                ],
                              ),
                            ),
                          ) ,
                        );
                      }
                      else{
                        // return AnimationConfiguration.staggeredList(
                        //   position: index,
                        //   child:SlideAnimation(
                        //     child: FadeInAnimation(
                        //       child: Row(
                        //         children: [
                        //           InkWell(
                        //             onTap: (){
                        //               modalBottomSheetMenu(context,taskList);
                        //             },
                        //             child: TaskTitleWidget(taskList:taskList,),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ) ,
                        // );
                        return Container();
                      }

                    });
              }))
            ],
          ),
        ),
      ),
    );
  }



  // void _settingModalBottomSheet() {
  //   final double imageRadius = 50;
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext bc) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Stack(
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(top: imageRadius),
  //                 padding: EdgeInsets.only(top: imageRadius),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(16),
  //                     topRight: Radius.circular(16),
  //                   ),
  //                   color: Colors.white,
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     Text('asdfsdf asdfasdf'),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         IconButton(
  //                           icon: Icon(Icons.message),
  //                           onPressed: () {},
  //                         ),
  //                         SizedBox(
  //                           width: 16,
  //                         ),
  //                         IconButton(
  //                           icon: Icon(Icons.message),
  //                           onPressed: () {},
  //                         ),
  //                         SizedBox(
  //                           width: 16,
  //                         ),
  //                         IconButton(
  //                           icon: Icon(Icons.message),
  //                           onPressed: () {},
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: CircleAvatar(
  //                   radius: imageRadius,
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  void modalBottomSheetMenu(BuildContext context, TaskModels taskList,) {
     Size size = MediaQuery.of(context).size;
     showModalBottomSheet(
         context: context,
         elevation: 100,
         isScrollControlled: true,
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(25.0),
             topRight: Radius.circular(25.0),
           ),
         ),
         builder: (contex) => SingleChildScrollView(
               child: Container(
                 child: Padding(
                   padding: MediaQuery.of(context).viewInsets,
                   child: Padding(
                     padding: EdgeInsets.all(20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           "Daily Routine Planner",
                           style: GoogleFonts.poppins(
                             color: const Color.fromARGB(255, 59, 59, 61),
                             fontSize: 20,
                             fontWeight: FontWeight.w900,
                           ),
                         ),
                         SizedBox(height: 4,),
                         InkWell(
                           onTap: (){
                             _taskController.delete(taskList);
                             Navigator.of(context).pop();
                             _taskController.getTask();
                           },
                           child: Container(
                             alignment: Alignment.center,
                             height: 40,
                             width: 200,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: Colors.lightGreenAccent
                             ),
                             child: Text("Delete"),
                           ),
                         ),
                         SizedBox(height: 4,),
                         InkWell(
                           onTap: (){
                              _taskController.markCompleted(taskList.id!);
                              Navigator.of(context).pop();
                              _taskController.getTask();
                           },
                           child: Container(
                             alignment: Alignment.center,
                             height: 40,
                             width: 200,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors.lightGreenAccent
                             ),
                             child: Text("Task Completed"),
                           ),
                         )

                       ],
                     ),
                   ),
                 ),
               ),
             ));
   }

  }
