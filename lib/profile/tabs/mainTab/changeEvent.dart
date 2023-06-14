// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ticketok/models/authModel.dart';

class ChangeEvent extends StatefulWidget {
  final Function(UserEvent name) changeEvent;
  final List<UserEvent> events;
  final UserEvent currentEvent;
  const ChangeEvent({super.key, required this.changeEvent, required this.events, required this.currentEvent});

  @override
  State<ChangeEvent> createState() => _ChangeEventState();


}

class _ChangeEventState extends State<ChangeEvent> {

  late UserEvent selectedEvent;

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
          //title: const Text('AlertDialog Title'),
          content: DropdownButtonExample(events: widget.events, currentEvent: widget.currentEvent, notifyParent: changeEvent,),
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
                Navigator.pop(context, 'OK'),
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

class DropdownButtonExample extends StatefulWidget {
  final List<UserEvent> events;
  final UserEvent currentEvent;
  final Function(UserEvent name) notifyParent;
  const DropdownButtonExample({super.key, required this.events, required this.notifyParent, required this.currentEvent});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  late UserEvent dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
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
        // This is called when the user selects an item.
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
