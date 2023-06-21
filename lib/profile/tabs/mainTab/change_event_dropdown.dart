import 'package:flutter/material.dart';
import '../../../models/user_event_info.dart';

class ChangeEventDropdown extends StatefulWidget {
  final List<UserEventInfo> events;
  final UserEventInfo currentEvent;
  final Function(UserEventInfo name) notifyParent;
  const ChangeEventDropdown({super.key, required this.events, required this.notifyParent, required this.currentEvent});

  @override
  State<ChangeEventDropdown> createState() => _ChangeEventDropdownState();
}

class _ChangeEventDropdownState extends State<ChangeEventDropdown> {
  late UserEventInfo dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.currentEvent;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<UserEventInfo>(
      value: dropdownValue,
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (UserEventInfo? value) {
        setState(() {
          widget.notifyParent(value!);
          dropdownValue = value;
        });
      },
      items: widget.events.map<DropdownMenuItem<UserEventInfo>>((UserEventInfo event) {
        return DropdownMenuItem<UserEventInfo>(
          value: event,
          child: Text(event.title),
        );
      }).toList(),
    );
  }
}
