import 'package:daily_routine_planner/component/stylesh_drawer.dart';
import 'package:daily_routine_planner/screen/add_task_screen.dart';
import 'package:daily_routine_planner/services_provider/Services_provider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
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
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    ).then((value) {
      setState(() {
        Provider.of<ServiceProvider>(context, listen: false).setTime(value!) ;
      });
    });
  }


  @override
  DateTime _selectedDate = DateTime.now();

  Widget build(BuildContext context) {
    print(_selectedDate);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                      _selectedDate = date;
                  },
                ),
              ),

              ListView.builder(
                  itemCount: 12,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context,index){
                return Card(
                  child: ListTile(
                    title: Text("hi"),
                    subtitle: Text("Task name "),
                    trailing: Icon(Icons.notifications_none_rounded),
                  ),
                );
              })
              
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

  void modalBottomSheetMenu(BuildContext context) {
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
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Center(
                           child: Text(
                             "Daily Routine Planner",
                             style: GoogleFonts.poppins(
                               color: const Color.fromARGB(255, 59, 59, 61),
                               fontSize: 20,
                               fontWeight: FontWeight.w900,
                             ),
                           ),

                         ),
                         TableCalendar(
                           calendarFormat: CalendarFormat.week,
                           firstDay: DateTime.utc(2010, 10, 16),
                           lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: Provider.of<ServiceProvider>(context, listen: false).selectedDay,
                           // focusedDay: DateTime.now(),
                           selectedDayPredicate: (day) {
                             return isSameDay(Provider.of<ServiceProvider>(context, listen: false).selectedDay, day);
                           },

                           onDaySelected: (selectedDay, focusedDay) {

                             setState(() {

                               Provider.of<ServiceProvider>(context, listen: false).setSelectedDay(selectedDay, focusedDay);
                             });
                           },
                         ),
                         Center(
                             child: Container(
                               alignment: Alignment.center,
                               height: 40,
                               width: 200,
                               decoration: BoxDecoration(

                                 borderRadius: BorderRadius.circular(20),
                               ),
                               child:TextButton.icon(onPressed: (){
                                 _showTimePicker();
                               },
                                   icon: Icon(Icons.schedule,size: 30,),
                                   label: Text(Provider.of<ServiceProvider>(context, listen: false).timeOfDay.format(context).toString(),style: GoogleFonts.poppins(
                                     color: Colors.black,
                                     fontSize: 20,
                                     fontWeight: FontWeight.w900,
                                   ),)),

                             )
                         ),
                        Padding(
                            padding:EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                              bottom: 10
                            ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.app_registration_sharp),
                              hintText: "Task Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(40)),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),

                         Center(
                           child: Container(
                             alignment: Alignment.center,
                             height: 40,
                             width: 200,
                             decoration: BoxDecoration(
                               color:Colors.lightBlue,
                               borderRadius: BorderRadius.circular(20),
                             ),
                             child: Text("Add Tast",style: GoogleFonts.poppins(
                               color: Colors.white,
                               fontSize: 16,
                               fontWeight: FontWeight.w900,
                             ),),
                           )
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ));
   }

  }
