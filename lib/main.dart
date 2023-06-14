// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'auth/auth.dart';
import 'profile/tabs.dart';

void main() {
  runApp(
    NewWidget(),
  );
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const Auth(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/profile': (context) => const ProfileMain(),
      },
    );
  }
}