import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/cubits/user_event_cubit.dart';
import 'package:ticketok/tickets_work/tickets_work.dart';
import 'auth/auth.dart';
import 'models/user.dart';
import 'scanner/scan_page.dart';
import 'profile/profile_main.dart';


void main() async {
  await Hive.initFlutter();
  runApp(
    const Ticketok(),
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
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit(User.empty())),
        BlocProvider<UserEventCubit>(create: (BuildContext context) => UserEventCubit(null))
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        title: 'Ticketok',
        initialRoute: '/',
        routes: {
          '/': (context) => const ProfileMain(),
          '/auth': (context) => const Auth(),
          '/scan': (context) => const Scan(),
          '/tickets_work': (context) => TicketsWorkPage()
        },
    ));
  }
}