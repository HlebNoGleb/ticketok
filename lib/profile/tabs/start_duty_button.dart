import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ticketok/scanner/scan_page.dart';

import '../../cubits/user_cubit.dart';
import '../../models/user.dart';
import '../../services/work_service.dart';

class StartDutyButton extends StatelessWidget{
  const StartDutyButton({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final User userData = context.watch<UserCubit>().state;
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Чтобы начать работу, нажмите кнопку ниже",
                  style: TextStyle(fontSize: 13),
                  ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor:const Color.fromRGBO(46, 125, 50, 1),
                  shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))
                ),
                onPressed: () async {
                  if (await confirm(
                      context,
                      textCancel: Text("Отменить"),
                      textOK: Text("Начать смену"),
                      content: Text("Вы действительно хотите начать смену?"),
                      )) {
                    startWork(userData.accessToken);
                  }
                },
                child: const Text('Начать смену',style: TextStyle(fontSize: 18, color: Colors.white),)
              )
            ],
          ),
        );
      }
    );
  }

  void startWork(String accessToken) async {
    var appSettingsBox = await Hive.openBox<bool>('app_settings');
    var isOffline = appSettingsBox.get('isOffline') ?? false;

    if (isOffline || await workStart(accessToken)) {
      Navigator.pushNamed(context, "/tickets_work");
    }
  }
}