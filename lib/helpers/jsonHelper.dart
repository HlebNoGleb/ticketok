// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

Future <Map<String, dynamic>> fetchData(String url, String container) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    const json = "{\"response\":{\"operator_id\":1,\"full_name\":\"СнежанаТихонова\",\"url_photo\":\"path/to/photo\",\"access_token\":\"test_token\",\"events\":[{\"id\":1,\"title\":\"VivaBraslav2023\"},{\"id\":2,\"title\":\"Рокзабобров2023\"}]},\"method\":\"operator.auth\"}";
    final test = jsonDecode(json);
    return test[container];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}