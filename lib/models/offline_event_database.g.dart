// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_event_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseAdapter extends TypeAdapter<Database> {
  @override
  final int typeId = 1;

  @override
  Database read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Database(
      fields[0] as String,
      (fields[1] as List).cast<Ticket>(),
    );
  }

  @override
  void write(BinaryWriter writer, Database obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.tickets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Database _$DatabaseFromJson(Map<String, dynamic> json) => Database(
      json['category'] as String,
      (json['tickets'] as List<dynamic>)
          .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatabaseToJson(Database instance) => <String, dynamic>{
      'category': instance.category,
      'tickets': instance.tickets,
    };
