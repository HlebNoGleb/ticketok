import 'package:json_annotation/json_annotation.dart';

part 'offline_event_database_ticket.g.dart';

@JsonSerializable()
class Ticket{
  final int id;

  @JsonKey(name: 'barcode_hash')
  final String barcodeHash;
  final String? time;

  bool? isChecked = false;

  Ticket(this.id, this.barcodeHash, this.time);

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}