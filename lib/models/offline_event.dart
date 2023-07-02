import 'package:json_annotation/json_annotation.dart';

import 'offline_event_database.dart';

part 'offline_event.g.dart';

@JsonSerializable()
class OfflineEvent{

  @JsonKey(name: 'operator_id')
  final int operatorId;

  @JsonKey(name: 'event_id')
  final int eventId;
  final List<Database> database;

  OfflineEvent(this.operatorId, this.eventId, this.database);

  factory OfflineEvent.fromJson(Map<String, dynamic> json) => _$OfflineEventFromJson(json);
}