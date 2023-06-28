import 'package:json_annotation/json_annotation.dart';

part 'ticket_check_transaction.g.dart';

@JsonSerializable()
class TicketCheckTransaction{
  final int id;
  final String type;
  final String title;
  final DateTime datetime;

  @JsonKey(name: 'operator_id') 
  final String? operatorId;

  @JsonKey(name: 'operator_name')
  final String? operatorName;

  TicketCheckTransaction(this.id, this.type, this.title, this.datetime, this.operatorId, this.operatorName);

  factory TicketCheckTransaction.fromJson(Map<String, dynamic> json) => _$TicketCheckTransactionFromJson(json);
}