import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticketok/models/user_event_info.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  final num operatorId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String urlPhoto;
  @HiveField(3)
  final String accessToken;
  @HiveField(4)
  final List<UserEventInfo> events;

  User({required this.operatorId, required this.fullName, required this.urlPhoto, required this.accessToken, required this.events});

  factory User.fromJson(Map <String, dynamic> json) => User(
    operatorId: json['operator_id'],
    fullName: json['full_name'],
    urlPhoto: json['url_photo'],
    accessToken: json['access_token'],
    events: (json["events"] as List).map((i) => UserEventInfo.fromJson(i)).toList()
  );

  factory User.empty() => User(
    operatorId: 0,
    fullName: '',
    urlPhoto:'',
    accessToken: '',
    events: List.empty()
  );

  bool isEmpty() => operatorId == 0 && events.isEmpty;
}