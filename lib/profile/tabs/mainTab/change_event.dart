import 'package:flutter/material.dart';
import 'package:ticketok/models/user.dart';
import '../../../models/user_event.dart';
import 'change_event_dropdown.dart';

class ChangeEvent extends StatefulWidget {
  final Function(UserEvent name) changeEvent;
  final List<UserEvent> events;
  final UserEvent currentEvent;
  const ChangeEvent({super.key, required this.changeEvent, required this.events, required this.currentEvent});

  @override
  State<ChangeEvent> createState() => _ChangeEventState();
}

class _ChangeEventState extends State<ChangeEvent> {

  late UserEvent selectedEvent = widget.currentEvent;

  void changeEvent(UserEvent newName){
    setState(() {
      selectedEvent = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: ChangeEventDropdown(events: widget.events, currentEvent: widget.currentEvent, notifyParent: changeEvent),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context, 'Cancel')
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {                
                widget.changeEvent(selectedEvent),
                Navigator.pop(context, 'OK')
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Изменить'),
    );
  }
}