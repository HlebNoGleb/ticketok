// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:js_interop';

import 'package:flutter/material.dart';
import '../models/authModel.dart';
import 'dart:convert';    
import 'package:http/http.dart';
import '../helpers/jsonHelper.dart';
import '../helpers/urls.dart' as Urls;

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String validationErrror = '';

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: loginController,
            decoration: const InputDecoration(
              hintText: 'Логин',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Введите логин';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("Для входа используйте логин 111 и любой пароль", style: TextStyle(color: Colors.black38),),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'Пароль',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Введите пароль';
              }
              return null;
            },
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      alignment: Alignment.center
                    ),
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {

                        var response = await _autorizeUserResponse(loginController.text, passwordController.text);

                        if(response.statusCode != 200){
                          setState(() {
                            validationErrror = jsonDecode(response.body)['error']["error_msg"];
                          });

                          return;
                        } 

                        var user = User.fromJson(jsonDecode(response.body)['response']);

                        // Process data
                        debugPrint(loginController.text);
                        debugPrint(passwordController.text);

                        debugPrint("go to profile");

                        Navigator.pushNamed(context, "/profile");
                      }
                    },
                    child: const Text('Войти'),
                  ),
                  Text(validationErrror)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Future<Response> _autorizeUserResponse(String login, String pass) async{
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$login:$pass'))}';
    debugPrint(basicAuth);

    Response r = await get(Uri.parse(Urls.AuthUrl),
      headers: <String, String>{'authorization': basicAuth});

    return r; 
  }
}