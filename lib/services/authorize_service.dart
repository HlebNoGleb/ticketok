import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:ticketok/models/auth_response.dart';
import '../helpers/urls.dart' as Urls;
import '../models/user.dart';

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

Future saveUserToHive(User user) async{
  var userBox = await Hive.openBox('user');

  await userBox.add(user);
}

Future isUserLoggedIn() async {
  var userBox = await Hive.openBox('user');

  return userBox.isEmpty;
}

Future logoutUser() async {
  var userBox = await Hive.openBox('user');

  await userBox.clear();
}
 
Future getUser() async{
  var userbox = await Hive.openBox('user');

  await userbox.getAt(0);
}