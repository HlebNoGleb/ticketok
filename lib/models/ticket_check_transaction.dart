import 'package:json_annotation/json_annotation.dart';

part 'ticket_check_transaction.g.dart';

@JsonSerializable()
class TicketCheckTransaction{
  final int id;
  final String type;
  final String title;
  final DateTime datetime;

  @JsonKey(name: 'operator_id') 
  final int? operatorId;

  @JsonKey(name: 'operator_name')
  final String? operatorName;

  @JsonKey()
  final String? holder;

  @JsonKey()
  final String? card;

  @JsonKey()
  final String? brand;

  @JsonKey()
  final String? email;

  TicketCheckTransaction(this.id, this.type, this.title, this.datetime, this.operatorId, this.operatorName, this.holder, this.card, this.brand, this.email);

  factory TicketCheckTransaction.fromJson(Map<String, dynamic> json) => _$TicketCheckTransactionFromJson(json);
}