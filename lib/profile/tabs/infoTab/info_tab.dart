import 'package:flutter/material.dart';
import 'package:ticketok/profile/tabs/infoTab/worked_hours.dart';
import 'package:ticketok/profile/tabs/start_duty_button.dart';

import '../../../models/user.dart';
import '../../../models/user_event.dart';
import 'info_schedule.dart';

class InfoTab extends StatelessWidget {

  final User? userModel;
  final UserEvent? currentEvent;

  const InfoTab({this.userModel, this.currentEvent, super.key });

  @override
    Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          WorkedHours(totalHours: currentEvent!.totalHours),
          const SizedBox(height: 16.0),
          InfoSchedule(timetable: currentEvent!.timetable),
          Divider(),
          StartDutyButton(context: context)
        ],
      ),
    );
  }
}