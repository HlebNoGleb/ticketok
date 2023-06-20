import 'package:flutter/material.dart';
import '../../../models/user_event.dart';

class ChangeEventDropdown extends StatefulWidget {
  final List<UserEvent> events;
  final UserEvent currentEvent;
  final Function(UserEvent name) notifyParent;
  const ChangeEventDropdown({super.key, required this.events, required this.notifyParent, required this.currentEvent});

  @override
  State<ChangeEventDropdown> createState() => _ChangeEventDropdownState();
}

class _ChangeEventDropdownState extends State<ChangeEventDropdown> {
  late UserEvent dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.currentEvent;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<UserEvent>(
      value: dropdownValue,
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (UserEvent? value) {
        setState(() {
          widget.notifyParent(value!);
          dropdownValue = value;
        });
      },
      items: widget.events.map<DropdownMenuItem<UserEvent>>((UserEvent event) {
        return DropdownMenuItem<UserEvent>(
          value: event,
          child: Text(event.title),
        );
      }).toList(),
    );
  }
}
