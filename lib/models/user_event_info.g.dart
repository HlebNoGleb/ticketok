// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_event_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEventInfoAdapter extends TypeAdapter<UserEventInfo> {
  @override
  final int typeId = 5;

  @override
  UserEventInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEventInfo(
      id: fields[0] as num,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserEventInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEventInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
