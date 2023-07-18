import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticketok/models/offline_event_database_ticket.dart';

import 'offline_event_database.dart';

part 'offline_event.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class OfflineEvent{

  @JsonKey(name: 'operator_id')
  @HiveField(0)
  final int operatorId;

  @JsonKey(name: 'event_id')
  @HiveField(1)
  final int eventId;

  @HiveField(2)
  final List<Ticket> database;

  OfflineEvent(this.operatorId, this.eventId, this.database);

  factory OfflineEvent.fromJson(Map<String, dynamic> json) => _$OfflineEventFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineEventToJson(this);
}