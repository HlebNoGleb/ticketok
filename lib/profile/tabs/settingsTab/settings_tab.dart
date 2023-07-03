import 'package:flutter/material.dart';
import 'package:ticketok/services/offline_ticket_service.dart';

import '../../../models/user.dart';

class SettingsTab extends StatelessWidget {

  final User? userModel;

  const SettingsTab({
    super.key, this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: sync, child: Text('test sync')),
        Chip(
          label: const Text('Aaron Burr'),
        ),
      ],
    );
  }

  void sync() async{
      var database = await downloadOfflineBase(userModel!.accessToken);

      await syncDatabase(database);

      var saved = await getDatabaseData();
  }
}