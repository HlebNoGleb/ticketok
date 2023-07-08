import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/cubits/user_event_cubit.dart';
import 'package:ticketok/models/offline_event.dart';
import 'package:ticketok/models/offline_event_database.dart';
import 'package:ticketok/models/offline_event_database_ticket.dart';
import 'package:ticketok/models/user_event.dart';
import 'package:ticketok/models/user_event_info.dart';
import 'package:ticketok/models/user_event_time_table.dart';
import 'package:ticketok/tickets_work/tickets_work.dart';
import 'auth/auth.dart';
import 'models/user.dart';
import 'scanner/scan_page.dart';
import 'profile/profile_main.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
    
  await Hive.initFlutter();
  Hive.registerAdapter(TicketAdapter());
  Hive.registerAdapter(DatabaseAdapter());
  Hive.registerAdapter(OfflineEventAdapter());

  Hive.registerAdapter(UserEventInfoAdapter());
  Hive.registerAdapter(UserAdapter());

  Hive.registerAdapter(UserEventTimeTableAdapter());
  Hive.registerAdapter(UserEventAdapter());


  var userBox = await Hive.openBox<User>('user');
  var savedUser = userBox.isEmpty ? null : userBox.getAt(0);

  var userEventBox = await Hive.openBox<UserEvent>('user_event');
  var savedEvent = userEventBox.isEmpty ? null : userEventBox.getAt(0);

  runApp(
    Ticketok(savedUser: savedUser, savedEvent: savedEvent),
  );
}

class Ticketok extends StatelessWidget {
  late User? savedUser;
  late UserEvent? savedEvent;

  Ticketok({
    super.key, this.savedUser, this.savedEvent
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit(savedUser ?? User.empty())),
        BlocProvider<UserEventCubit>(create: (BuildContext context) => UserEventCubit(savedEvent))
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