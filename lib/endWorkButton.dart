// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:ticketok/profile/profile_main.dart';
import 'package:ticketok/services/work_service.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

import 'cubits/user_cubit.dart';
import 'cubits/user_event_cubit.dart';
import 'models/user.dart';
import 'models/user_event.dart';

class EndWorkButton extends StatelessWidget {
  const EndWorkButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final User userData = context.watch<UserCubit>().state;
        final UserEvent? currentEvent = context.watch<UserEventCubit>().state;
        return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  minimumSize: Size.fromHeight(80),
                  shape: const ContinuousRectangleBorder()
                ),
                onPressed: () async {
                  await endWorkWithConfirm(context, userData, currentEvent);
                },
                child: const FittedBox(
                  child: Text("ЗАВЕРШИТЬ СМЕНУ", style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  )),
                ),
              );
      }
    );
  }

  static Future endWorkWithConfirm(BuildContext context, User userData, UserEvent? currentEvent) async {
    if (await needConfirm(context)) {
      endWork(context, userData.accessToken, currentEvent);
    }
  }

  static Future<bool> needConfirm(BuildContext context) async{
    return await confirm(
                      context,
                      textCancel: Text("Отменить"),
                      textOK: Text("Завершить"),
                      content: Text("Вы действительно хотите завершить текущую смену?"),
                      );
  }

  static void endWork(BuildContext context, String accessToken, UserEvent? currentEvent) async {
    var appSettingsBox = await Hive.openBox<bool>('app_settings');
    var isOffline = appSettingsBox.get('isOffline') ?? false;
    if(isOffline){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
        return const ProfileMain();
      }));

      return;
    }

    var totalHours = await workStop(accessToken);

    if (totalHours != null) {
      if (currentEvent != null){
        currentEvent.totalHours = totalHours;
        await BlocProvider.of<UserEventCubit>(context).setCurrentEvent(currentEvent);
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
        return const ProfileMain();
      }));
    }
  }
}