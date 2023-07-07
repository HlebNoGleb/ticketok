import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offline_event_database_ticket.dart';

part 'offline_event_database.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Database{
  @HiveField(0)
  final String category; // удалить после нового апи и пересобрать сгенерированные скрипты

  @HiveField(1)
  final List<Ticket> tickets; // удалить после нового апи и пересобрать сгенерированные скрипты

  // @HiveField(1)
  // final int id;

  // @JsonKey(name: 'barcode_hash')
  // @HiveField(2)
  // final String barcodeHash;

  // @HiveField(3)
  // final String? time;

  // @HiveField(4, defaultValue: false)
  // bool? isChecked = false;

  // Database(this.id, this.barcodeHash, this.time);

  Database(this.category, this.tickets); // удалить после нового апи и пересобрать сгенерированные скрипты

  factory Database.fromJson(Map<String, dynamic> json) => _$DatabaseFromJson(json);
}