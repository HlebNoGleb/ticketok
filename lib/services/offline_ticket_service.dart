import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:ticketok/models/offline_event.dart';
import 'package:ticketok/models/ticket_check_response.dart';
import '../helpers/urls.dart' as Urls;

import 'package:crypto/crypto.dart';

import '../models/offline_event_database_ticket.dart';

Future<OfflineEvent> downloadOfflineBase(String userToken) async{
    Response httpResponse = await get(Uri.parse(Urls.GetOfflineBase),
      headers: {
        // 'authorization': 'Bearer $userToken',
        'authorization': 'Bearer test_token',
        "Content-Type": "application/x-www-form-urlencoded"
        }
      );

    var json = jsonDecode(httpResponse.body);

    return OfflineEvent.fromJson(json['response']);
}

Future syncDatabase(OfflineEvent event) async{
  var box = await Hive.openBox<OfflineEvent>('offline_events');
  
  var current = box.get(event.eventId);

  if(current == null){
    box.put(event.eventId, event);
    return;
  }
  
  box.put(event.eventId, event);
}

Future<OfflineEvent?> getDatabaseData() async{
  var box = await Hive.openBox<OfflineEvent>('offline_events');

  return box.getAt(0);
}

Future<TicketCheckResponse> checkTicketOffline(String ticket, num eventId) async {
  var ticketHash = sha256.convert(utf8.encode(ticket)).toString();
  var box = await Hive.openBox<OfflineEvent>('offline_events');

  var currentEvent = box.getAt(0);

  var ticketObj = currentEvent!.database.where((element) => element.barcodeHash == ticketHash).firstOrNull;

  if(ticketObj != null){

    if(ticketObj.time != null){
      ticketObj.time = DateTime.now().toString();

      box.put(currentEvent.eventId, currentEvent);

      return TicketCheckResponse.validTicket(ticket);
    }
    
    if(ticketObj.time != null){
      return TicketCheckResponse.invalidTicket(ticket, ErrorType.reEntry);
    }
  }

  return TicketCheckResponse.invalidTicket(ticket, ErrorType.notFound);
}