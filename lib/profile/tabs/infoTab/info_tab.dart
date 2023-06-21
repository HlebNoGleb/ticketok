import 'package:flutter/material.dart';
import 'package:ticketok/profile/tabs/infoTab/worked_hours.dart';
import 'package:ticketok/profile/tabs/start_duty_button.dart';

import '../../../models/user.dart';
import '../../../models/user_event.dart';

class InfoTab extends StatelessWidget {
  
  final User? userModel;
  final UserEvent? currentEvent;

  const InfoTab({this.userModel, this.currentEvent, super.key });

  @override
    Widget build(BuildContext context) {
    return Column(
      children: [
        WorkedHours(totalHours: currentEvent!.totalHours),
        const StartDutyButton()
      ],
    );
  }
}