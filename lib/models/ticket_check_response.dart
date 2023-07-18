import 'package:json_annotation/json_annotation.dart';
import 'package:ticketok/models/ticket_check_transaction.dart';

part "ticket_check_response.g.dart";

enum ErrorType {
  @JsonValue('re-entry') reEntry,
  @JsonValue('not-allowed') notAllowed,
  @JsonValue('not-found') notFound
}

@JsonSerializable()
class TicketCheckResponse{
  final String ticket;

  @JsonKey(name: 'is_valid')
  final bool isValid;

  @JsonKey(name: 'error_type')
  final ErrorType? errorType;

  @JsonKey(name: 'error_msg')
  final String? errorMessage;

  @JsonKey(name: 'error_msg_friendly')
  final String? errorMessageFriendly;

  final List<TicketCheckTransaction>? transactions;

  TicketCheckResponse(this.ticket, this.isValid, this.errorType, this.errorMessage, this.errorMessageFriendly, this.transactions);

  factory TicketCheckResponse.fromJson(Map<String, dynamic> json) => _$TicketCheckResponseFromJson(json);

  factory TicketCheckResponse.validTicket(String ticket) => TicketCheckResponse(
    ticket, 
    true,
    null,
    null,
    null, 
    null);

  factory TicketCheckResponse.invalidTicket(String ticket, ErrorType errorType, {String? ticketTime}) {
    
    var errorMessageFriendly = switch(errorType){
      ErrorType.notAllowed => 'Категория билета не соответствует разрешенным для данного сканера. Объясните гостю, где он может обменять свой билет.',
      ErrorType.reEntry => 'Откажите гостю во входе, объяснив ситуацию. При необходимости пригласите менеджера входной группы.',
      ErrorType.notFound => 'Билет не найден. Возможно, билет подделан. Проверьте билет еще раз, при необходимости позовите менеджера.'
    };

    var errorMessage = switch(errorType){
      ErrorType.notAllowed => "Невалидный билет",
      ErrorType.reEntry => "Повторный вход",
      ErrorType.notFound => "Билет не найден"
    };

    var transactions = errorType == ErrorType.reEntry && ticketTime != null 
      ? List<TicketCheckTransaction>.filled(1, new TicketCheckTransaction(0, '', 'Вход', DateTime.parse(ticketTime), null, ''))
      : null; 

    return TicketCheckResponse(
      ticket,
      false, 
      errorType,
      errorMessage,
      errorMessageFriendly,
      transactions
    );
  }
}