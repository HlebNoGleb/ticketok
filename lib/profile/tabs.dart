// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ticketok/models/event.dart';
import 'tabs/mainTab/mainTab.dart';
import 'tabs/infoTab/infoTab.dart';
import 'tabs/settingsTab/settingsTab.dart';
import 'package:ticketok/models/authModel.dart';
import 'dart:async';

class ProfileMain extends StatefulWidget {
  const ProfileMain({
    super.key
  });

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
    userData = auth();
    // eventData = getById(userData.events[0].id) as Event;
  }

  void changeEvent(UserEvent event){
    setState(() {
      // userData = fetchData2();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: "Главная", ),
              Tab(text: "Инфо", ),
              Tab(text: "Настройки", ),
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                FutureBuilder <User> (
                  future: userData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator(),
                    );
                    }
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('${snapshot.error}'),
                      );
                    }
                    if (snapshot.hasData) {
                      return MainTab(userModel: snapshot.data, changeEvent: changeEvent);
                    }
                    return Text("1234");
                  }
                ),
              ],
            ),
            InfoTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}