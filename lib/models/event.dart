// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class Event {
  final num event_id;
  final String title;
  final List<String> permitted_zones;
  final Map<String, String> timetable;
  final String total_hours;

  Event({required this.event_id, required this.title, required this.permitted_zones, required this.timetable, required this.total_hours});

  factory Event.fromJson(Map <String, dynamic> json) => Event(
    event_id: json['event_id'],
    title: json['title'],
    permitted_zones: json['permitted_zones'],
    timetable: json['timetable'],
    total_hours: json['total_hours'],
  );
}


