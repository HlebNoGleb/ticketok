// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

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

Future <Event> getById(num id) async {
  await Future.delayed(const Duration(seconds: 1));
  const testJson = "{\"response\":{\"event_id\":1,\"title\":\"VivaBraslav2023\",\"permitted_zones\":[\"Vip2дня\",\"Кемпинг4дня\",\"АвтоGarage4дня\"],\"timetable\":[{\"from\":\"2023-05-01T00:00:00\",\"to\":\"2023-05-02T01:00:00\"},{\"from\":\"2023-05-01T00:00:00\",\"to\":\"2023-05-02T01:00:00\"}],\"total_hours\":\"123421\"},\"method\":\"events.getById\"}";
  final event = Event.fromJson(jsonDecode(testJson));
  return event;
}


