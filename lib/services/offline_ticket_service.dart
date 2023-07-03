import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:ticketok/models/offline_event.dart';
import '../helpers/urls.dart' as Urls;

Future<OfflineEvent> DownloadOfflineBase(String userToken) async{
    Response httpResponse = await get(Uri.parse(Urls.GetOfflineBase),
      headers: {
        'authorization': 'Bearer $userToken',
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
}

Future<OfflineEvent?> getDatabaseData() async{
  var box = await Hive.openBox<OfflineEvent>('offline_events');

  return box.getAt(0);
}