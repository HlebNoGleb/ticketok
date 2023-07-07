// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ticketok/logoutButton.dart';
import 'package:ticketok/services/offline_ticket_service.dart';

import '../../../loader.dart';
import '../../../models/user.dart';

class SettingsTab extends StatefulWidget{

  final User? userModel;

  const SettingsTab({super.key, this.userModel});

  @override
  State<StatefulWidget> createState() => SettingsTabState();
}

class SettingsTabState extends State<SettingsTab> {

  late User? userModel;
  late Box<bool> appSettingsBox;
  late bool isOffline;
  String syncText = "";

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    isOffline = false;
    setAppSettingsBox();
  }

  void setAppSettingsBox() async {
    appSettingsBox = await Hive.openBox<bool>('app_settings');

    setState(() {
      isOffline = appSettingsBox.get('isOffline') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              Text("Ticketok",
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
              Text("Версия 1.0",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    color: Color.fromRGBO(0, 0, 0, .5)
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Частное предприятие «Левол Групп»",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      color: Color.fromRGBO(0, 0, 0, .5)
                    ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Оффлайн-режим",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    color: Color.fromRGBO(0, 0, 0, .5)
                  )
                ),
                Switch(value: isOffline, onChanged: switchOfflineMode),
              ],
            ),
            ElevatedButton(onPressed: sync, child: Text('Синхронизировать данные')),
            Text(syncText),
          ],
        ),
        LogoutButton(context: context)
      ],
    );
    // return Column(
    //   children: [
    //     ElevatedButton(onPressed: sync, child: Text('Synchronize data')),
    //     Switch(value: isOffline, onChanged: switchOfflineMode),
    //     Chip(
    //       label: const Text('Aaron Burr'),
    //     ),
    //   ],
    // );
  }

  void switchOfflineMode(bool value){
    appSettingsBox.put('isOffline', value);

    setState(() {
      isOffline = value;
    });
  }

  void sync() async {
    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (_, __, ___) => Loader(), opaque: false)
    );

    var database =await downloadOfflineBase(userModel!.accessToken);

    await syncDatabase(database);

    var saved = await getDatabaseData();

    if (saved != null){
        Navigator.pop(context);
        setState(() {
          syncText = "Данные синхронизованы";
        });
    }
  }

}