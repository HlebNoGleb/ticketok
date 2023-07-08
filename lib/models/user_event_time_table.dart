
import 'package:hive/hive.dart';

part 'user_event_time_table.g.dart';

@HiveType(typeId: 7)
class UserEventTimeTable{
  @HiveField(0)
  DateTime from;
  @HiveField(1)
  DateTime to;

  UserEventTimeTable({required this.from,required this.to});

  factory UserEventTimeTable.fromJson(Map<String, dynamic> json) => UserEventTimeTable(
    from: DateTime.parse(json['from']),
    to: DateTime.parse(json['to'])
    );
}