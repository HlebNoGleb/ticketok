// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_event_database_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      json['id'] as int,
      json['barcode_hash'] as String,
      json['time'] as String?,
    )..isChecked = json['isChecked'] as bool?;

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'barcode_hash': instance.barcodeHash,
      'time': instance.time,
      'isChecked': instance.isChecked,
    };
