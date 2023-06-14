// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Text("Вход в Ticketok",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 30,
                  color: Color.fromRGBO(0, 0, 0, 1)
                ),
              ),
            Text("Система сканирования билетов",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  color: Color.fromRGBO(0, 0, 0, .5)
                ),
            ),
            SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AuthForm(),
              ),
            ),
          ],
        )
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



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
              child: ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center
                ),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    debugPrint(loginController.text);
                    debugPrint(passwordController.text);
                    if (loginController.text == "111"){
                      debugPrint("go to profile");
                      Navigator.pushNamed(context, "/profile");
                    }
                  }
                },
                child: const Text('Войти'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}