import 'dart:convert';

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