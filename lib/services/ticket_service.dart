import 'dart:convert';

import 'package:http/http.dart';
import 'package:ticketok/models/ticket_check_response.dart';
import 'package:ticketok/models/user_event.dart';
import '../helpers/urls.dart' as Urls;

Future<TicketCheckResponse> checkTicket(String ticket, num eventId, String userToken) async{
    Response httpResponse = await post(Uri.parse(Urls.TicketsCheckUrl),
      body: {
        'event_id': eventId.toString(),
        'barcode' : ticket
      },
      headers: {
        'authorization': 'Bearer $userToken',
        "Content-Type": "application/x-www-form-urlencoded"
        }
      );

    var json = jsonDecode(httpResponse.body);

    return TicketCheckResponse.fromJson(json['response']); 
}