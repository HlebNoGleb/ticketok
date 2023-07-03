import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offline_event_database_ticket.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Ticket{

  @HiveField(0)
  final int id;

  @JsonKey(name: 'barcode_hash')
  @HiveField(1)
  final String barcodeHash;

  @HiveField(2)
  final String? time;

  @HiveField(3, defaultValue: false)
  bool? isChecked = false;

  Ticket(this.id, this.barcodeHash, this.time);

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}