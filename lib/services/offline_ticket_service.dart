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
        'authorization': 'Bearer $userToken',
        // 'authorization': 'Bearer test_token',
        "Content-Type": "application/x-www-form-urlencoded"
        }
      );

    var json = jsonDecode(httpResponse.body);

    return OfflineEvent.fromJson(json['response']);
}

Future<OfflineEvent> syncOfflineBase(String userToken, OfflineEvent event) async{
    Response httpResponse = await post(Uri.parse(Urls.SetOfflineBase),
      headers: {
        'authorization': 'Bearer $userToken',
        // 'authorization': 'Bearer test_token',
        "Content-Type": "application/json"
        },
      body: jsonEncode(event.database)
      );

    var json = jsonDecode(httpResponse.body);

    return OfflineEvent.fromJson(json['response']);
}

Future syncDatabase(String userToken) async{
  var box = await Hive.openBox<OfflineEvent>('offline_events');
  
  var current = box.isEmpty ? null : box.getAt(0);

  if(current == null){
    var event = await downloadOfflineBase(userToken);

    box.put(event.eventId, event);

    return;

  } 

  var newEvent = await syncOfflineBase(userToken, current);

  box.putAt(0, newEvent);
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

    if(ticketObj.time == null){
      ticketObj.time = DateTime.now().toString();

      box.put(currentEvent.eventId, currentEvent);

      return TicketCheckResponse.validTicket(ticket);
    }
    
    if(ticketObj.time != null){
      return TicketCheckResponse.invalidTicket(ticket, ErrorType.reEntry, ticketTime : ticketObj.time);
    }
  }

  return TicketCheckResponse.invalidTicket(ticket, ErrorType.notFound);
}