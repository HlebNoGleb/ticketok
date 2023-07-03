import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offline_event_database_ticket.dart';

part 'offline_event_database.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Database{
  @HiveField(0)
  final String category;


  @HiveField(1)
  final List<Ticket> tickets; // удалить после раскоментирования и пересобрать сгенерированные скрипты

  // @HiveField(2)
  // final int id;

  // @JsonKey(name: 'barcode_hash')
  // @HiveField(3)
  // final String barcodeHash;

  // @HiveField(4)
  // final String? time;

  // @HiveField(5, defaultValue: false)
  // bool? isChecked = false;

  // Database(this.category, this.tickets, this.id, this.barcodeHash, this.time);
  Database(this.category, this.tickets);

  factory Database.fromJson(Map<String, dynamic> json) => _$DatabaseFromJson(json);
}