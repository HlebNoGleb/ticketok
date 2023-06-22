import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticketok/models/user_event.dart';

class InfoSchedule extends StatelessWidget{
  
  List<UserEventTimeTable> timetable;

  InfoSchedule({super.key,required this.timetable});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,      
      children: displayTimetable(),
    );
  }

  List<Widget> displayTimetable() {
    List<Widget> result = List<Widget>.empty(growable: true);

    var header =const Text('График работы', style: TextStyle(color: Colors.grey));
    result.add(header);

    DateFormat dateFormat = DateFormat("dd.MM.yyy HH:mm");

    for(final item in timetable) {
      result.add(Text('${dateFormat.format(item.from)} - ${dateFormat.format(item.to)}', style: const TextStyle(color: Colors.grey)));
    }
    
    return result;
  }
}