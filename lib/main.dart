// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/auth/cubit/user_cubit.dart';
import 'auth/auth.dart';
import 'models/authModel.dart';
import 'models/scan_page.dart';
import 'profile/tabs.dart';

void main() {
  runApp(
    Ticketok(),
  );
}

class Ticketok extends StatelessWidget {
  const Ticketok({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit(User.empty()))
      ], 
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        title: 'Ticketok',
        initialRoute: '/',
        routes: {
          '/': (context) => const Auth(),
          '/profile': (context) => const ProfileMain(),
          '/scan': (context) => const Scan(),
        },
    ));
  }
}