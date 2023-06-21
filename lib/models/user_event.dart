import 'dart:core';

class UserEvent {

  num id;
  String title;
  List<String> permitedZones;
  num totalHours;
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
    totalHours: int.parse(json['total_hours']),
    permitedZones: (json['permitted_zones'] as List).map((obj) => obj as String).toList(),
    timetable: (json['timetable'] as List).map((obj) => UserEventTimeTable.fromJson(obj)).toList()
  );
}

class UserEventTimeTable{
  DateTime from;
  DateTime to;

  UserEventTimeTable({required this.from,required this.to});

  factory UserEventTimeTable.fromJson(Map<String, dynamic> json) => UserEventTimeTable(
    from: DateTime.parse(json['from']), 
    to: DateTime.parse(json['to'])
    );
}