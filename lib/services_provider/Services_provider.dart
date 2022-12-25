

import 'package:flutter/material.dart';

class ServiceProvider extends ChangeNotifier{

  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  TimeOfDay get timeOfDay =>_timeOfDay;
  DateTime get selectedDay => _selectedDay;
  DateTime get  focusedDay => _focusedDay;

 setTime(TimeOfDay timeOfDay){
   _timeOfDay = timeOfDay;
   notifyListeners();
 }
 setSelectedDay(DateTime selectedDay,DateTime focusedDay){

   _selectedDay=selectedDay;
   _focusedDay=focusedDay;
   notifyListeners();
 }


}