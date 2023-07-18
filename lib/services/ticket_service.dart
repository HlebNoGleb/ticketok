import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:ticketok/models/ticket_check_response.dart';
import 'package:ticketok/services/offline_ticket_service.dart';
import '../helpers/urls.dart' as Urls;

Future<TicketCheckResponse> checkTicket(String ticket, num eventId, String userToken, BuildContext context) async{

    var appSettingsBox = await Hive.openBox<bool>('app_settings');
    var isOffline = appSettingsBox.get('isOffline') ?? false;

    if(isOffline){
      return checkTicketOffline(ticket, eventId);
    }

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

    if(httpResponse.statusCode == 401){
      await Navigator.pushNamedAndRemoveUntil(context, "/auth", ModalRoute.withName('/'));
    }

    var json = jsonDecode(httpResponse.body);

    return TicketCheckResponse.fromJson(json['response']);
}