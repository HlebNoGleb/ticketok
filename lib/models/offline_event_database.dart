import 'package:json_annotation/json_annotation.dart';

import 'offline_event_database_ticket.dart';

part 'offline_event_database.g.dart';

@JsonSerializable()
class Database{
  final String category;
  final List<Ticket> tickets;

  Database(this.category, this.tickets);

  factory Database.fromJson(Map<String, dynamic> json) => _$DatabaseFromJson(json);
}