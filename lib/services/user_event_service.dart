import 'dart:convert';

import 'package:http/http.dart';
import 'package:ticketok/models/user_event.dart';
import '../helpers/urls.dart' as Urls;

Future<UserEvent> GetEventById(num eventId, String userToken) async{
    Response httpResponse = await post(Uri.parse(Urls.EventByIdUrl),
      body: {'event_id': eventId.toString()},
      headers: {
        'authorization': 'Bearer $userToken',
        "Content-Type": "application/x-www-form-urlencoded"
        }
      );

    var json = jsonDecode(httpResponse.body);

    return UserEvent.fromJson(json['response']); 
}