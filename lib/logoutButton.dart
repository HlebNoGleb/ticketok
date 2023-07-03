// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketok/profile/profile_main.dart';
import 'package:ticketok/services/work_service.dart';

import 'cubits/user_cubit.dart';
import 'cubits/user_event_cubit.dart';
import 'models/user.dart';
import 'models/user_event.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              minimumSize: Size.fromHeight(80),
              shape: const ContinuousRectangleBorder()
            ),
            onPressed: (){
              logout();
            },
            child: const Text("Выйти из аккаунта", style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            )),
          );
  }

  void logout() {
    BlocProvider.of<UserCubit>(context).logout();
    Navigator.pushNamed(context, "/");
  }
}