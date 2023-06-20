import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/cubits/user_cubit.dart';
import 'package:ticketok/models/event.dart';
import '../models/user_event.dart';
import 'tabs/mainTab/main_tab.dart';
import 'tabs/infoTab/info_tab.dart';
import 'tabs/settingsTab/settings_tab.dart';
import 'package:ticketok/models/user.dart';
import 'dart:async';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State <ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State <ProfileMain> {
  late String eventName;
  late Future<User> userData;
  late Event eventData;

  @override
  void initState() {
    super.initState();
  }

  void changeEvent(UserEvent event){
    setState(() {
      // userData = fetchData2();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, User>(builder: (BuildContext context, User userData) {    
      return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Главная", ),
              Tab(text: "Инфо", ),
              Tab(text: "Настройки", ),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            MainTab(userModel: userData),
            const InfoTab(),
            const SettingsTab(),
          ],
        ),
      ),
    );
    });
  }
}