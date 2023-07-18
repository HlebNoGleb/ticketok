import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ticketok/models/user_event.dart';
import '../helpers/urls.dart' as Urls;

Future<int?> workStop(String userToken, BuildContext context) async {
    Response httpResponse = await get(Uri.parse(Urls.WorkStopUrl),
      headers: {
        'authorization': 'Bearer $userToken',
        "Content-Type": "application/x-www-form-urlencoded"
        }
      );

    if(httpResponse.statusCode == 401){
      return null;
    }

    var json = jsonDecode(httpResponse.body);

    if (httpResponse.statusCode == 200) {
      var totalHours = json['response']['total_hours'];
      return totalHours;
    }

    return null;
}

Future<bool> workStart(String userToken, BuildContext context) async {
    Response httpResponse = await get(Uri.parse(Urls.WorkStartUrl),
      headers: {
        'authorization': 'Bearer $userToken',
        "Content-Type": "application/x-www-form-urlencoded"
        }
      );

    if(httpResponse.statusCode == 401){
      await Navigator.pushNamedAndRemoveUntil(context, "/auth", ModalRoute.withName('/'));
    }

    if (httpResponse.statusCode == 200) {
      return true;
    }

    return false;
}