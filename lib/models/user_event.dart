import 'dart:core';

import 'package:hive/hive.dart';
import 'package:ticketok/models/user_event_time_table.dart';

part 'user_event.g.dart';

@HiveType(typeId: 6)
class UserEvent {

  @HiveField(0)
  num id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<String> permitedZones;
  @HiveField(3)
  num totalHours;
  @HiveField(4)
  List<UserEventTimeTable> timetable;


  UserEvent({
    required this.id,
    required this.title,
    required this.permitedZones,
    required this.totalHours,
    required this.timetable
    });

  factory UserEvent.fromJson(Map <String, dynamic> json) => UserEvent(
    id: json['event_id'],
    title: json['title'],
    totalHours: json['total_hours'],
    permitedZones: (json['permitted_zones'] as List).map((obj) => obj as String).toList(),
    timetable: (json['timetable'] as List).map((obj) => UserEventTimeTable.fromJson(obj)).toList()
  );
}
