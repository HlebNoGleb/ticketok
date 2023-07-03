import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ticketok/services/offline_ticket_service.dart';

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
      children: [
        ElevatedButton(onPressed: sync, child: Text('Synchronize data')),
        Switch(value: isOffline, onChanged: switchOfflineMode),
        Chip(
          label: const Text('Aaron Burr'),
        ),
      ],
    );
  }

  void switchOfflineMode(bool value){
    appSettingsBox.put('isOffline', value);

    setState(() {
      isOffline = value;
    });
  }

  void sync() async{
      var database =await downloadOfflineBase(userModel!.accessToken);

      await syncDatabase(database);

      var saved = await getDatabaseData();
  }

}