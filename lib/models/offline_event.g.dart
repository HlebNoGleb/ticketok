// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineEventAdapter extends TypeAdapter<OfflineEvent> {
  @override
  final int typeId = 0;

  @override
  OfflineEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineEvent(
      fields[0] as int,
      fields[1] as int,
      (fields[2] as List).cast<Ticket>(),
    );
  }

  @override
  void write(BinaryWriter writer, OfflineEvent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.operatorId)
      ..writeByte(1)
      ..write(obj.eventId)
      ..writeByte(2)
      ..write(obj.database);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineEvent _$OfflineEventFromJson(Map<String, dynamic> json) => OfflineEvent(
      json['operator_id'] as int,
      json['event_id'] as int,
      (json['database'] as List<dynamic>)
          .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfflineEventToJson(OfflineEvent instance) =>
    <String, dynamic>{
      'operator_id': instance.operatorId,
      'event_id': instance.eventId,
      'database': instance.database,
    };
