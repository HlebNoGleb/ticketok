import 'package:hive/hive.dart';

part 'user_event_info.g.dart';

@HiveType(typeId: 5)
class UserEventInfo {
  @HiveField(0)
  num id;
  @HiveField(1)
  String title;

  UserEventInfo({required this.id, required this.title});

  factory UserEventInfo.fromJson(Map <String, dynamic> json) => UserEventInfo(
    id: json['id'],
    title: json['title']
  );
}