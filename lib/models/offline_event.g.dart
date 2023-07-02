// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineEvent _$OfflineEventFromJson(Map<String, dynamic> json) => OfflineEvent(
      json['operator_id'] as int,
      json['event_id'] as int,
      (json['database'] as List<dynamic>)
          .map((e) => Database.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfflineEventToJson(OfflineEvent instance) =>
    <String, dynamic>{
      'operator_id': instance.operatorId,
      'event_id': instance.eventId,
      'database': instance.database,
    };
