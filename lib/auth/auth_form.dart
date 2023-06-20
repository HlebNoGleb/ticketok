// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/services/authorize_service.dart';
import 'package:ticketok/services/validation_service.dart';

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
            decoration: const InputDecoration(hintText: 'Пароль'),
            validator: validatePassword,
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

    var authResponse = await authorizeUser(loginController.text, passwordController.text);

    if(authResponse.error != null){
      setState(() {
        validationErrror = authResponse.error!;
      });

      return;
    } 

    BlocProvider.of<UserCubit>(context).login(authResponse.user!);

    await Navigator.pushNamed(context, "/profile");
  }
}