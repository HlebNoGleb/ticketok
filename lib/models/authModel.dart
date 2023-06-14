// ignore_for_file: non_constant_identifier_names, camel_case_types, library_prefixes
import 'package:flutter/foundation.dart';
import 'package:ticketok/helpers/jsonHelper.dart' as jsonHelper;

class Auth {
  final String Username;
  final String Password;

  Auth(this.Username, this.Password);
}


class User {
  final num operator_id;
  final String full_name;
  final String url_photo;
  final String access_token;
  final List<UserEvent> events;

  User({required this.operator_id, required this.full_name, required this.url_photo, required this.access_token, required this.events});

  factory User.fromJson(Map <String, dynamic> json) => User(
    operator_id: json['operator_id'],
    full_name: json['full_name'],
    url_photo: json['url_photo'],
    access_token: json['access_token'],
    // events: <List<UserEvent>.fromJson(json['events']),
    events: (json["events"] as List).map((i) => UserEvent.fromJson(i)).toList()
  );
}

class UserEvent {

  num id;
  String title;

  UserEvent({required this.id, required this.title});

  factory UserEvent.fromJson(Map <String, dynamic> json) => UserEvent(
    id: json['id'],
    title: json['title'],
    // events: json['events'],
  );
}

// void Test() {
//   final test = jsonHelper.fetchData("url", "container");
//   User.fromJson(test as Map<String, dynamic>);
// }

Future <User> fetchData() async {
  await Future.delayed(const Duration(seconds: 1));
  const testJson = "{\"response\":{\"operator_id\":1,\"full_name\":\"СнежанаТихонова\",\"url_photo\":\"path/to/photo\",\"access_token\":\"test_token\",\"events\":[{\"id\":1,\"title\":\"VivaBraslav2023\"},{\"id\":2,\"title\":\"Рокзабобров2023\"}]},\"method\":\"operator.auth\"}";
  final userJson = await jsonHelper.fetchData("https://jsonplaceholder.typicode.com/photos/2", "response", testJson);
  final user = User.fromJson(userJson);
  debugPrint(user.full_name);
  return user;
}