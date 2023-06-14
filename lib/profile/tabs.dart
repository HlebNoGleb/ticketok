// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'tabs/mainTab/mainTab.dart';
import 'tabs/infoTab/infoTab.dart';
import 'tabs/settingsTab/settingsTab.dart';
import 'package:ticketok/models/authModel.dart' as user;
import 'dart:async';

class ProfileMain extends StatefulWidget {
  const ProfileMain({
    super.key
  });

  @override
  State <ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State <ProfileMain> {
  final String eventName = "111";
  late Future <user.User> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = user.fetchData();
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
                FutureBuilder <user.User> (
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                     // return Text(snapshot.data!.title);
                      return MainTab(userModel: snapshot.data);
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('${snapshot.error}'),
                      );
                    }
                    // By default, show a loading spinner.
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator(),
                    );
                  },
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