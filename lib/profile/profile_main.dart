import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/cubits/user_event_cubit.dart';
import '../auth/auth.dart';
import '../models/user_event.dart';
import 'tabs/mainTab/main_tab.dart';
import 'tabs/infoTab/info_tab.dart';
import 'tabs/settingsTab/settings_tab.dart';
import 'package:ticketok/models/user.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State <ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State <ProfileMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {

      final User userData = context.watch<UserCubit>().state;
      final UserEvent? currentEvent = context.watch<UserEventCubit>().state;

      if(userData.isEmpty()){
        Future.microtask(() => Navigator.pushNamed(
          context,
        "/auth"
        ));

        return const Scaffold();
      }

      return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
               Tab(child: Text("Главная", style: TextStyle(fontSize: 15, color: Colors.white)),),
               Tab(child: Text("Инфо", style: TextStyle(fontSize: 15, color: Colors.white)),),
                Tab(child: Text("Настройки", style: TextStyle(fontSize: 15, color: Colors.white)),),
            ],
          ),
          title: const Text('Профиль работника', style: TextStyle(fontSize: 24, color: Colors.white)),
          backgroundColor: Color.fromRGBO(33, 150, 243, 1),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  MainTab(userModel: userData, currentEvent: currentEvent),
                  InfoTab(userModel: userData, currentEvent: currentEvent),
                  SettingsTab(userModel: userData,),
                ],
              ),
            )
          ],
        ),
      ),
    );
    });
  }
}