// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEventAdapter extends TypeAdapter<UserEvent> {
  @override
  final int typeId = 6;

  @override
  UserEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEvent(
      id: fields[0] as num,
      title: fields[1] as String,
      permitedZones: (fields[2] as List).cast<String>(),
      totalHours: fields[3] as num,
      timetable: (fields[4] as List).cast<UserEventTimeTable>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserEvent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.permitedZones)
      ..writeByte(3)
      ..write(obj.totalHours)
      ..writeByte(4)
      ..write(obj.timetable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
