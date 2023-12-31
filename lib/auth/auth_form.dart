// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/cubits/user_event_cubit.dart';
import 'package:ticketok/profile/tabs/settingsTab/settings_tab.dart';
import 'package:ticketok/scanner/scan_page.dart';
import 'package:ticketok/services/authorize_service.dart';
import 'package:ticketok/services/user_event_service.dart';
import 'package:ticketok/services/validation_service.dart';

import '../loader.dart';
import '../profile/profile_main.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? validationErrror;

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: loginController,
            decoration: const InputDecoration(hintText: 'Логин'),
            validator: validateLogin,
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: 'Пароль',),
            validator: validatePassword,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
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
                    onPressed: submit,
                    child: const Text('Войти'),
                  ),
                  Text(validationErrror != null ? validationErrror! : '')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit() async{

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_, __, ___) => Loader(), opaque: false)
    );

    var authResponse = await authorizeUser(loginController.text, passwordController.text);

    if(authResponse.error != null){
      setState(() {
        validationErrror = authResponse.error!;
      });

      Navigator.pop(context);
      return;
    }
    var user = authResponse.user!;
    await BlocProvider.of<UserCubit>(context).login(user);

    var event = await GetEventById(user.events.first.id, user.accessToken);

    await BlocProvider.of<UserEventCubit>(context).setCurrentEvent(event);

    Navigator.pop(context);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
        return const ProfileMain();
    }));
  }


}