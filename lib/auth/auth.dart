// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:ticketok/auth/auth_form.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: Image.asset('assets/images/logo.png')
              ),
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

