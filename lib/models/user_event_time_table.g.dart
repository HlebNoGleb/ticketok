// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event_time_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEventTimeTableAdapter extends TypeAdapter<UserEventTimeTable> {
  @override
  final int typeId = 7;

  @override
  UserEventTimeTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEventTimeTable(
      from: fields[0] as DateTime,
      to: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserEventTimeTable obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.to);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEventTimeTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
