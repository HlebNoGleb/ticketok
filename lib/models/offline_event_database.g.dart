// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_event_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Database _$DatabaseFromJson(Map<String, dynamic> json) => Database(
      json['category'] as String,
      (json['tickets'] as List<dynamic>)
          .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatabaseToJson(Database instance) => <String, dynamic>{
      'category': instance.category,
      'tickets': instance.tickets,
    };
