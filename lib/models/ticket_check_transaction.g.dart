// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_check_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketCheckTransaction _$TicketCheckTransactionFromJson(
        Map<String, dynamic> json) =>
    TicketCheckTransaction(
      json['id'] as int,
      json['type'] as String,
      json['title'] as String,
      DateTime.parse(json['datetime'] as String),
      json['operator_id'] as int?,
      json['operator_name'] as String?,
    );

Map<String, dynamic> _$TicketCheckTransactionToJson(
        TicketCheckTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'datetime': instance.datetime.toIso8601String(),
      'operator_id': instance.operatorId,
      'operator_name': instance.operatorName,
    };
