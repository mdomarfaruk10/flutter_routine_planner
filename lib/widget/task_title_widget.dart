import 'package:daily_routine_planner/models/taskmodels.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TaskTitleWidget extends StatelessWidget {
  final TaskModels? taskList;
  TaskTitleWidget({ required this.taskList});

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 10),
      width: 340,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(taskList!.color??0)
        ),
        child: Row(
          children: [
            Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(taskList!.title??"",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white

                        )
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded,size: 18,color: Colors.grey[200],)
                      ],
                    ),
                    SizedBox(width: 4,),
                    Text("${taskList!.startTime} - ${taskList!.endTime}",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[100]

                          )
                      ),
                    ),
                    Text(taskList!.note??"",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          )
                      ),
                    ),
                  ],
                ),
            ),
            Container(
              height: 50,
              width: 0.5,
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(taskList!.isCompleted == 1 ?"COMPLETED":"TODO",
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
  _getBGClr(int no){
    switch(no){
      case 0:
        return Colors.indigo;
      case 1:
        return Colors.pinkAccent;
      case 2:
        return Colors.amber;
        default:
          return Colors.indigo;


    }
  }
}
