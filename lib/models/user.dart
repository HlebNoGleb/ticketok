import 'package:ticketok/models/user_event_info.dart';

class User {
  final num operatorId;
  final String fullName;
  final String urlPhoto;
  final String accessToken;
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