import 'package:json_annotation/json_annotation.dart';
import 'package:ticketok/models/ticket_check_transaction.dart';

part "ticket_check_response.g.dart";

enum ErrorType {@JsonValue('re-entry') reEntry, @JsonValue('not-allowed') notAllowed,@JsonValue('not-found') notFound}

@JsonSerializable()
class TicketCheckResponse{
  final String ticket;

  @JsonKey(name: 'is_valid')
  final bool isValid;

  @JsonKey(name: 'error_type')
  final String? errorType;

  @JsonKey(name: 'error_msg')
  final String? errorMessage;

  @JsonKey(name: 'error_msg_friendly')
  final String? errorMessageFriendly;

  final List<TicketCheckTransaction>? transactions;

  TicketCheckResponse(this.ticket, this.isValid, this.errorType, this.errorMessage, this.errorMessageFriendly, this.transactions);

  factory TicketCheckResponse.fromJson(Map<String, dynamic> json) => _$TicketCheckResponseFromJson(json);
}