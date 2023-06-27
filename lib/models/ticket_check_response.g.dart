// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketCheckResponse _$TicketCheckResponseFromJson(Map<String, dynamic> json) =>
    TicketCheckResponse(
      json['ticket'] as String,
      json['is_valid'] as bool,
      json['error_type'] as String?,
      json['error_msg'] as String?,
      json['error_msg_friendly'] as String?,
      (json['transactions'] as List<dynamic>?)
          ?.map(
              (e) => TicketCheckTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketCheckResponseToJson(
        TicketCheckResponse instance) =>
    <String, dynamic>{
      'ticket': instance.ticket,
      'is_valid': instance.isValid,
      'error_type': instance.errorType,
      'error_msg': instance.errorMessage,
      'error_msg_friendly': instance.errorMessageFriendly,
      'transactions': instance.transactions,
    };
