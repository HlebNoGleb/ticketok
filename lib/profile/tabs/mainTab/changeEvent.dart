import 'package:flutter/material.dart';

class ChangeEvent extends StatelessWidget {
  final Function(String name) notifyParent;
  const ChangeEvent({super.key, required this.notifyParent});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                notifyParent("111"),
                Navigator.pop(context, 'Cancel')
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {
                notifyParent("222"),
                Navigator.pop(context, 'OK'),
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}