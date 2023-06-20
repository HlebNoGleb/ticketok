import 'dart:convert';
import 'package:http/http.dart';
import 'package:ticketok/models/auth_response.dart';
import '../helpers/urls.dart' as Urls;
import '../models/authModel.dart';

Future<AuthResponse> authorizeUser(String login, String pass) async{
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$login:$pass'))}';

    Response httpResponse = await get(Uri.parse(Urls.AuthUrl),
      headers: <String, String>{'authorization': basicAuth});

    var json = jsonDecode(httpResponse.body);

    if(httpResponse.statusCode != 200){
      return AuthResponse(error: json['error']["error_msg"]);
    }

    return AuthResponse(user: User.fromJson(json['response'])); 
}

 